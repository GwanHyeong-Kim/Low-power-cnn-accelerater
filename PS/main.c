#include <stdio.h>
#include "data.h"
#include "xparameters.h"
#include "xil_io.h"
#include <stdlib.h>
#include <string.h>

// 각 BRAM의 데이터 레지스터
const u32 mem_in_data_regs[] = {
    MEM_IN_0_DATA_REG, MEM_IN_1_DATA_REG, MEM_IN_2_DATA_REG, MEM_IN_3_DATA_REG,
    MEM_IN_4_DATA_REG, MEM_IN_5_DATA_REG, MEM_IN_6_DATA_REG, MEM_IN_7_DATA_REG,
    MEM_IN_8_DATA_REG, MEM_IN_9_DATA_REG, MEM_IN_10_DATA_REG, MEM_IN_11_DATA_REG,
    MEM_IN_12_DATA_REG, MEM_IN_13_DATA_REG, MEM_IN_14_DATA_REG, MEM_IN_15_DATA_REG
};

const u32 mem_out_data_regs[] = {
    MEM_OUT_0_DATA_REG, MEM_OUT_1_DATA_REG, MEM_OUT_2_DATA_REG, MEM_OUT_3_DATA_REG,
    MEM_OUT_4_DATA_REG, MEM_OUT_5_DATA_REG, MEM_OUT_6_DATA_REG, MEM_OUT_7_DATA_REG,
    MEM_OUT_8_DATA_REG, MEM_OUT_9_DATA_REG, MEM_OUT_10_DATA_REG, MEM_OUT_11_DATA_REG,
    MEM_OUT_12_DATA_REG, MEM_OUT_13_DATA_REG, MEM_OUT_14_DATA_REG, MEM_OUT_15_DATA_REG,
    MEM_OUT_16_DATA_REG, MEM_OUT_17_DATA_REG
};

// 28x28 이미지 데이터를 출력하는 함수
void print_image(int8_t* image, int in_h, int in_w) {
    printf("+--------------------------------------------------------+\n");
    for (int i = 0; i < in_h; i++) {
        printf("|");
        for (int j = 0; j < in_w; j++) {
            int8_t pixel = image[i * in_w + j];
            if (pixel == -128) {
                printf("  ");
            } else {
                printf("@@");
            }
        }
        printf("|\n");
    }
    printf("+--------------------------------------------------------+\n\n");
}

// 범위 확인 함수
int check_range(int index, int limit) {
    return (index >= 0 && index < limit);
}

// im2col 변환 함수
void im2col_8(const int8_t *input, int in_c, int in_h, int in_w, int k_h, int k_w, int out_h, int out_w, int stride, int padding, int8_t *output) {
    int mat_j = 0;

    for (int c = 0; c < in_c; c++) {
        for (int kh = 0; kh < k_h; kh++) {
            for (int kw = 0; kw < k_w; kw++) {
                for (int oh = 0; oh < out_h; oh++) {
                    int in_j = oh * stride + kh - padding;

                    for (int ow = 0; ow < out_w; ow++) {
                        int in_i = ow * stride + kw - padding;

                        if (check_range(in_j, in_h) && check_range(in_i, in_w)) {
                            output[mat_j * out_h * out_w + oh * out_w + ow] = input[(c * in_h + in_j) * in_w + in_i];
                        } else {
                            output[mat_j * out_h * out_w + oh * out_w + ow] = 0;
                        }
                    }
                }
                mat_j++;
            }
        }
    }
}

void im2col_32(const int32_t *input, int in_c, int in_h, int in_w, int k_h, int k_w, int out_h, int out_w, int stride, int padding, int32_t *output) {
    int mat_j = 0;

    for (int c = 0; c < in_c; c++) {
        for (int kh = 0; kh < k_h; kh++) {
            for (int kw = 0; kw < k_w; kw++) {
                for (int oh = 0; oh < out_h; oh++) {
                    int in_j = oh * stride + kh - padding;

                    for (int ow = 0; ow < out_w; ow++) {
                        int in_i = ow * stride + kw - padding;

                        if (check_range(in_j, in_h) && check_range(in_i, in_w)) {
                            output[mat_j * out_h * out_w + oh * out_w + ow] = input[(c * in_h + in_j) * in_w + in_i];
                        } else {
                            output[mat_j * out_h * out_w + oh * out_w + ow] = 0;
                        }
                    }
                }
                mat_j++;
            }
        }
    }
}

// col2im에서 사용하는 pixel 추가 함수
void col2im(const int32_t *data_col, int channels, int height, int width, int32_t *data_im) {
    // 데이터를 단순히 복사 (data_col의 모든 데이터를 data_im으로 이동)
    for (int i = 0; i < channels * height * width; i++) {
        data_im[i] = data_col[i];
    }
}

// ReLU 함수
void relu(int32_t *matrix, int total_elements) {
    for (int i = 0; i < total_elements; i++) {
        if (matrix[i] < 0) {
            matrix[i] = 0;
        }
    }
}

void max_pooling(const int32_t *input_data, int channels, int height, int width, int pool_h, int pool_w, int stride, int32_t *output_data) {
    int out_h = (height - pool_h) / stride + 1;
    int out_w = (width - pool_w) / stride + 1;

    for (int c = 0; c < channels; c++) {
        for (int y = 0; y < out_h; y++) {
            int y_start = y * stride;
            for (int x = 0; x < out_w; x++) {
                int x_start = x * stride;

                // 각 영역에서 최대값을 찾음
                int32_t max_val = input_data[(c * height + y_start) * width + x_start];
                for (int i = 0; i < pool_h; i++) {
                    for (int j = 0; j < pool_w; j++) {
                        int h_index = y_start + i;
                        int w_index = x_start + j;
                        int32_t val = input_data[(c * height + h_index) * width + w_index];
                        if (val > max_val) {
                            max_val = val;
                        }
                    }
                }
                // 결과 저장
                output_data[(c * out_h + y) * out_w + x] = max_val;
            }
        }
    }
}

// 변환된 im2col 결과를 출력하는 함수
void print_matrix_8(const int8_t *matrix, int m, int n, int show_all) {
    printf("Shape: [%d x %d]\n", m, n);

    if (show_all) {
        // 전체 출력
        for (int i = 0; i < m; i++) {
            printf("[");
            for (int j = 0; j < n; j++) {
                printf("%4d ", matrix[i * n + j]);
            }
            printf("]\n");
        }
    } else {
        // 일부 생략하여 출력
        int rows_to_display = 3;  // 앞뒤로 표시할 행의 개수

        for (int i = 0; i < m; i++) {
            // 앞 3개 행 출력
            if (i < rows_to_display || i >= m - rows_to_display) {
                printf("[");

                // 각 행에서 앞 3개 요소 출력
                for (int j = 0; j < 3 && j < n; j++) {
                    printf("%4d ", matrix[i * n + j]);
                }

                // 열 생략 표시
                if (n > 6) {
                    printf("... ");
                }

                // 각 행에서 뒤 3개 요소 출력
                for (int j = n - 3; j < n; j++) {
                    if (j >= 3) {  // 유효 인덱스 확인
                        printf("%4d ", matrix[i * n + j]);
                    }
                }

                printf("]\n");
            }

            // 중간 행 생략 표시
            else if (i == rows_to_display) {
                printf("...\n");
            }
        }
    }
}

// 변환된 32bit Matrix 결과를 출력하는 함수
void print_matrix_32(const int32_t *matrix, int m, int n, int show_all) {
    printf("Shape: [%d x %d]\n", m, n);

    if (show_all) {
        // 전체 출력
        for (int i = 0; i < m; i++) {
            printf("[");
            for (int j = 0; j < n; j++) {
                printf("%4d ", matrix[i * n + j]);
            }
            printf("]\n");
        }
    } else {
        // 일부 생략하여 출력
        int rows_to_display = 3;  // 앞뒤로 표시할 행의 개수

        for (int i = 0; i < m; i++) {
            // 앞 3개 행 출력
            if (i < rows_to_display || i >= m - rows_to_display) {
                printf("[");

                // 각 행에서 앞 3개 요소 출력
                for (int j = 0; j < 3 && j < n; j++) {
                    printf("%4d ", matrix[i * n + j]);
                }

                // 열 생략 표시
                if (n > 6) {
                    printf("... ");
                }

                // 각 행에서 뒤 3개 요소 출력
                for (int j = n - 3; j < n; j++) {
                    if (j >= 3) {  // 유효 인덱스 확인
                        printf("%4d ", matrix[i * n + j]);
                    }
                }

                printf("]\n");
            }

            // 중간 행 생략 표시
            else if (i == rows_to_display) {
                printf("...\n");
            }
        }
    }
}

// im2col의 역변환 결과를 출력하는 함수
void print_im(const int32_t *im, int channels, int height, int width) {
    printf("Shape: [%d x %d x %d]\n", channels, height, width);
    for (int c = 0; c < channels; ++c) {
        printf("Channel %d:\n", c);
        for (int h = 0; h < height; ++h) {
            printf("[");
            for (int w = 0; w < width; ++w) {
                printf("%4d ", im[(c * height + h) * width + w]);
            }
            printf("]\n");
        }
        printf("\n");
    }
}

// BRAM에 각 행을 저장하는 함수
void save_data_to_multiple_brams_8(const int8_t *input_matrix, int input_rows, int input_cols, const uint8_t *weight_matrix, int weight_rows, int weight_cols) {
    for (int bram_idx = 0; bram_idx < 16; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_IN_ADDR_REG * AXI_DATA_BYTE), 0x00000000);

        for (int row_set = 0; row_set < (weight_rows / 4); row_set++) { // 
            for (int col_set = 0; col_set < (weight_cols / 16); col_set++) {
                // 하나의 작은 세트
                for (int weight_idx = 3; weight_idx >= 0; weight_idx--) {
                    int data = weight_matrix[(weight_idx + row_set * 4) * weight_cols + (bram_idx + col_set * 16)]; 
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);                   
                }
                for (int blank = 0; blank < bram_idx; blank++) {
                    int data = 0;
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);
                }
                for (int input_idx = 0; input_idx < input_cols; input_idx++) {
                    int data = input_matrix[(bram_idx + col_set * 16) * input_cols + (input_idx)]; 
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);                   
                }
                for (int blank = 15; blank > bram_idx; blank--) {
                    int data = 0;
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);
                }
            }
        }
    }
}

// BRAM에 각 행을 저장하는 함수
void save_data_to_multiple_brams_32(const int32_t *input_matrix, int input_rows, int input_cols, const uint8_t *weight_matrix, int weight_rows, int weight_cols) {
    for (int bram_idx = 0; bram_idx < 16; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_IN_ADDR_REG * AXI_DATA_BYTE), 0x00000000);

        for (int row_set = 0; row_set < (weight_rows / 4); row_set++) { // 
            for (int col_set = 0; col_set < (weight_cols / 16); col_set++) {
                // 하나의 작은 세트
                for (int weight_idx = 3; weight_idx >= 0; weight_idx--) {
                    int data = weight_matrix[(weight_idx + row_set * 4) * weight_cols + (bram_idx + col_set * 16)]; 
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);                   
                }
                for (int blank = 0; blank < bram_idx; blank++) {
                    int data = 0;
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);
                }
                for (int input_idx = 0; input_idx < input_cols; input_idx++) {
                    int data = input_matrix[(bram_idx + col_set * 16) * input_cols + (input_idx)]; 
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);                   
                }
                for (int blank = 15; blank > bram_idx; blank--) {
                    int data = 0;
                    Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);
                }
            }
        }
    }
}

void print_to_multiple_brams(int cols, int show_all) {
    printf("Bram shape: [%d x %d]\n", 16, cols);
    for (int bram_idx = 0; bram_idx < 16; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_IN_ADDR_REG * AXI_DATA_BYTE), 0x00000000);
        if (bram_idx < 10) {
            printf("BRAM  %d: [", bram_idx);
        }
        else {
            printf("BRAM %d: [", bram_idx);
        }

        // 전체 출력
        for (int col_idx = 0; col_idx < cols; col_idx++) {
            int read_data = Xil_In32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE));
            if (show_all) {
                printf("%4d", read_data);
                if (col_idx < cols - 1) {
                    printf(" ");
                }
            }
            else {
                int items_to_display = 5; // 앞뒤로 표시할 열의 개수
                if (col_idx < items_to_display) {
                    printf("%4d ", read_data);
                }
                else if (col_idx == items_to_display) {
                    printf(" ... ");
                }
                else if (col_idx >= cols - items_to_display) {
                    printf("%4d ", read_data);
                } 
            }
            
        }
        printf("]\n");
    }
}

int32_t* save_from_bram_out_layer_1(int cols) {
    // 4 * cols 만큼 동적 메모리 할당
    int32_t* flattened_data = (int32_t*)malloc(4 * cols * sizeof(int32_t));
    for (int bram_idx = 0; bram_idx < 4; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_OUT_ADDR_REG * AXI_DATA_BYTE), 0x00000000);
        for (int col_idx = 0; col_idx < cols; col_idx++) {
            // BRAM에서 데이터 읽기
            int read_data = Xil_In32(XPAR_TOP_0_BASEADDR + (mem_out_data_regs[bram_idx] * AXI_DATA_BYTE));
            // 1차원 배열에 데이터 저장
            flattened_data[bram_idx * cols + col_idx] = read_data;
        }
    }
    return flattened_data; // 1차원 배열 주소 반환
}

int32_t* save_from_bram_out_layer_2(int cols) {
    // 8 * cols 만큼 동적 메모리 할당 및 0으로 초기화
    int32_t* flattened_data = (int32_t*)calloc(8 * cols, sizeof(int32_t));
    for (int bram_idx = 0; bram_idx < 8; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_OUT_ADDR_REG * AXI_DATA_BYTE), 0x00000000);
        for (int repeat = 0; repeat < 4; repeat++) { // (8, 64) * (64, 81) -> 64 / 16 = 4번 반복 (1회차 저장, 2~4회차 누적)
            for (int col_idx = 0; col_idx < cols; col_idx++) {
                // BRAM에서 데이터 읽기
                int read_data = Xil_In32(XPAR_TOP_0_BASEADDR + (mem_out_data_regs[bram_idx] * AXI_DATA_BYTE));
                // 1차원 배열에 데이터 누적
                flattened_data[bram_idx * cols + col_idx] += read_data;
            }
        }
    }
    return flattened_data; // 1차원 배열 주소 반환
}

int32_t* save_from_bram_out_layer_3(int cols) {
    // 16 * cols 만큼 동적 메모리 할당 및 0으로 초기화
    int32_t* flattened_data = (int32_t*)calloc(16 * cols, sizeof(int32_t));
    for (int bram_idx = 0; bram_idx < 16; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_OUT_ADDR_REG * AXI_DATA_BYTE), 0x00000000);
        for (int repeat = 0; repeat < 8; repeat++) { // (16, 128) * (128, 1) -> 128 / 16 = 8번 반복
            for (int col_idx = 0; col_idx < cols; col_idx++) {
                // BRAM에서 데이터 읽기
                int read_data = Xil_In32(XPAR_TOP_0_BASEADDR + (mem_out_data_regs[bram_idx] * AXI_DATA_BYTE));
                // 1차원 배열에 데이터 누적
                flattened_data[bram_idx * cols + col_idx] += read_data;
            }
        }
    }
    return flattened_data; // 1차원 배열 주소 반환
}

int32_t* save_from_bram_out_layer_4(int cols) {
    // 4 * cols 만큼 동적 메모리 할당
    int32_t* flattened_data = (int32_t*)malloc(1 * cols * sizeof(int32_t));
    // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
    Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_OUT_ADDR_REG * AXI_DATA_BYTE), 0x00000000);
    for (int col_idx = cols - 1; col_idx >= 0; col_idx--) {
        // BRAM에서 데이터 읽기
        int read_data = Xil_In32(XPAR_TOP_0_BASEADDR + (mem_out_data_regs[4] * AXI_DATA_BYTE));
        // 1차원 배열에 데이터 저장
        flattened_data[col_idx] = read_data;
    }
    return flattened_data; // 1차원 배열 주소 반환
}

// BRAM에 각 행을 저장하는 함수 (16x1) * (10x16)
void save_data_to_multiple_brams_IS(const int32_t *input_matrix, int input_rows, int input_cols, const uint8_t *weight_matrix, int weight_rows, int weight_cols) {
    for (int bram_idx = 0; bram_idx < 16; bram_idx++) {
        // BRAM 주소 초기화 (각 BRAM의 address 레지스터에 0 써서 초기화)
        Xil_Out32(XPAR_TOP_0_BASEADDR + (MEM_IN_ADDR_REG * AXI_DATA_BYTE), 0x00000000);

        int data = input_matrix[bram_idx]; 
        Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data); 

        for (int blank = 0; blank < bram_idx; blank++) {
            int data = 0;
            Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);
        }
        for (int row = weight_rows - 1; row >= 0; row--) {
            int data = weight_matrix[row * weight_cols + bram_idx]; 
            Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data); 
        }
        for (int blank = 15; blank > bram_idx; blank--) {
            int data = 0;
            Xil_Out32(XPAR_TOP_0_BASEADDR + (mem_in_data_regs[bram_idx] * AXI_DATA_BYTE), (u32)data);
        }
    }
}

int find_max_index(int32_t* array, int size) {
    int max_index = 0; // 초기 최대값의 인덱스는 첫 번째 요소
    int32_t max_value = array[0]; // 초기 최대값은 첫 번째 요소의 값
    for (int i = 1; i < size; i++) { // 두 번째 요소부터 반복
        if (array[i] > max_value) {
            max_value = array[i];
            max_index = i;
        }
    }
    return max_index;
}

int main() {
    int STATE = -1;
    char image_input[1600];
    int8_t image_data[28*28*2 + 1];

    while(1) {
    ////// IDLE
        int in_h = 28, in_w = 28, in_c = 1;
        int k_h = 4, k_w = 4;
        int pool_h = 2, pool_w = 2, stride = 1, padding = 0;
        int out_h = (in_h - k_h + 2 * padding) / stride + 1;
        int out_w = (in_w - k_w + 2 * padding) / stride + 1;
        int rows = in_c * k_h * k_w; 
        int cols = out_h * out_w;    
        int total_elements = rows * cols;

        printf("////////////////////////////// IDLE: Ready to take action. //////////////////////////////\n");   
        scanf("%s", image_input);
        if (!strcmp(image_input, "quit")) {
            break;
        }

        size_t len = strlen(image_input) - 1;
        size_t num_bytes = len / 2;
        int label = image_input[len - 1] - 48; // char to int
        int isPrint = image_input[len] - 48;
        for (size_t i = 0; i < num_bytes; i++) {
            sscanf(&image_input[i * 2], "%2hhx", &image_data[i]);
        }

        if (isPrint) {
            printf("\n* Image\n");
            print_image(image_data, 28, 28);
        }

        if (isPrint) {
            printf("* Input im2col transform\n");
        }
        int8_t *layer1_input = (int8_t *)malloc(total_elements * sizeof(int8_t));
        im2col_8(image_data, in_c, in_h, in_w, k_h, k_w, out_h, out_w, stride, padding, layer1_input);
        if (isPrint) {
            print_matrix_8(layer1_input, rows, cols, FALSE);
        }        

    ////// L1_INPUT_BRAM
        Xil_Out32((XPAR_TOP_0_BASEADDR) + (STATE_OUT_REG * AXI_DATA_BYTE), (u32)(L1_INPUT_BRAM));
        do{
            STATE = Xil_In32((XPAR_TOP_0_BASEADDR) + (STATE_IN_REG * AXI_DATA_BYTE));
        } while(STATE != L1_INPUT_BRAM);
        if (isPrint) {
            printf("\n////////////////////////////// L1_INPUT_BRAM: Ready to save input data in bram. //////////////////////////////\n"); 
        }

        // 변환된 결과를 BRAM에 저장
        if (isPrint) {
            printf("\n* Save im2col input to Bram\n");
        }
        save_data_to_multiple_brams_8(layer1_input, rows, cols, layer1_weights, layer1_shape[0], layer1_shape[1]);
        if (isPrint) {
            printf("Complete\n");
        }

        // BRAM에 저장한 데이터를 출력
        if (isPrint) {
            printf("\n* Retrieved im2col output from Input BRAMs:\n");
            print_to_multiple_brams(((layer1_shape[0] / 4) * (layer1_shape[1] / 16) * (4 + cols + 15)), FALSE);
        }

        // 동적 메모리 해제
        free(layer1_input);

    ////// L1_EN0
        Xil_Out32((XPAR_TOP_0_BASEADDR) + (STATE_OUT_REG * AXI_DATA_BYTE), (u32)(L1_EN_0));
        if (isPrint) {
            printf("\n////////////////////////////// L1_EN0: Ready to calculate layer 1. //////////////////////////////\n"); 
        }

    ////// L2_INPUT_BRAM
        do{
            STATE = Xil_In32((XPAR_TOP_0_BASEADDR) + (STATE_IN_REG * AXI_DATA_BYTE));
        } while(STATE != L2_INPUT_BRAM);
        if (isPrint) {
            printf("\n////////////////////////////// L2_INPUT_BRAM: Done Calculation for layer 1. //////////////////////////////\n"); 
        }
        
        rows = 4;
        cols = 625;
        total_elements = rows * cols;
        int32_t *layer1_output = save_from_bram_out_layer_1(cols);

        if (isPrint) {
            printf("\n* Layer1 output\n");
            print_matrix_32(layer1_output, rows, cols, FALSE);
        }
        
        if (isPrint) {
            printf("\n* Layer1 output ReLU\n");
        }
        relu(layer1_output, total_elements);
        if (isPrint) {
            print_matrix_32(layer1_output, rows, cols, FALSE);
        }

        if (isPrint) {
            printf("\n* Layer1 col2im transform\n");
        }
        in_h = 25, in_w = 25; in_c = 4;
        int32_t *col2im_output = (int32_t *)calloc(in_c * in_h * in_w, sizeof(int32_t));
        col2im(layer1_output, in_c, in_h, in_w, col2im_output);
        if (isPrint) {
            print_im(col2im_output, in_c, in_h, in_w);
        }

        if (isPrint) {
            printf("* Layer1 Max Pooling\n");
        }
        stride = 2;
        out_h = (in_h - pool_h) / stride + 1;
        out_w = (in_w - pool_w) / stride + 1;
        int32_t *max_pooling_output = (int32_t *)malloc(in_c * out_h * out_w * sizeof(int32_t));
        max_pooling(col2im_output, in_c, in_h, in_w, pool_h, pool_w, stride, max_pooling_output);
        if (isPrint) {
            print_im(max_pooling_output, in_c, out_h, out_w);
        }

        if (isPrint) {
            printf("* Layer2 input\n");
        }
        in_h = 12, in_w = 12; in_c = 4; stride = 1; 
        out_h = (in_h - k_h + 2 * padding) / stride + 1;
        out_w = (in_w - k_w + 2 * padding) / stride + 1;
        rows = in_c * k_h * k_w; 
        cols = out_h * out_w;     
        total_elements = rows * cols;
        int32_t *layer2_input = (int32_t *)malloc(total_elements * sizeof(int32_t));
        im2col_32(max_pooling_output, in_c, in_h, in_w, k_h, k_w, out_h, out_w, stride, padding, layer2_input);
        for (int i = 0; i < total_elements; i++) {
            layer2_input[i] = (int32_t)(layer2_input[i] / 128.0);
        };
        if (isPrint) {
            print_matrix_32(layer2_input, rows, cols, FALSE);
        }

        // 변환된 결과를 BRAM에 저장
        if (isPrint) {
            printf("\n* Save im2col input to Bram\n");
        }
        save_data_to_multiple_brams_32(layer2_input, rows, cols, layer2_weights, layer2_shape[0], layer2_shape[1]);
        if (isPrint) {
            printf("Complete\n");
        }

        // BRAM에 저장한 데이터를 출력
        if (isPrint) {
            printf("\n* Retrieved im2col output from multiple BRAMs:\n");
            print_to_multiple_brams((layer2_shape[0] / 4) * (layer2_shape[1] / 16) * (4 + cols + 15), FALSE);
        }

        // 동적 메모리 해제
        free(col2im_output);
        free(layer1_output);
        free(max_pooling_output);
        free(layer2_input);

    ////// L2_EN0
        Xil_Out32((XPAR_TOP_0_BASEADDR) + (STATE_OUT_REG * AXI_DATA_BYTE), (u32)(L2_EN_0));
        if (isPrint) {
            printf("\n////////////////////////////// L2_EN0: Ready to calculate layer 2. //////////////////////////////\n"); 
        }

    ////// L3_INPUT_BRAM
        do{
            STATE = Xil_In32((XPAR_TOP_0_BASEADDR) + (STATE_IN_REG * AXI_DATA_BYTE));
        } while(STATE != L3_INPUT_BRAM);
        if (isPrint) {
            printf("\n////////////////////////////// L3_INPUT_BRAM: Done Calculation for layer 2. //////////////////////////////\n"); 
        }

        rows = 8;
        cols = 81;
        total_elements = rows * cols;
        int32_t *layer2_output = save_from_bram_out_layer_2(cols);

        if (isPrint) {
            printf("\n* Layer2 output\n");
            print_matrix_32(layer2_output, rows, cols, FALSE);
        }
        
        if (isPrint) {
            printf("\n* Layer2 output ReLU\n");
        }
        relu(layer2_output, total_elements);
        if (isPrint) {
            print_matrix_32(layer2_output, rows, cols, FALSE);
        }

        if (isPrint) {
            printf("\n* Layer2 col2im transform\n");
        }
        in_h = 9, in_w = 9; in_c = 8;
        int32_t *col2im_output_2 = (int32_t *)calloc(in_c * in_h * in_w, sizeof(int32_t));
        col2im(layer2_output, in_c, in_h, in_w, col2im_output_2);
        if (isPrint) {
            print_im(col2im_output_2, in_c, in_h, in_w);
        }

        if (isPrint) {
            printf("* Layer2 Max Pooling\n");
        }
        stride = 2;
        out_h = (in_h - pool_h) / stride + 1;
        out_w = (in_w - pool_w) / stride + 1;
        int32_t *max_pooling_output_2 = (int32_t *)malloc(in_c * out_h * out_w * sizeof(int32_t));
        max_pooling(col2im_output_2, in_c, in_h, in_w, pool_h, pool_w, stride, max_pooling_output_2);
        if (isPrint) {        
            print_im(max_pooling_output_2, in_c, out_h, out_w);
        }

        if (isPrint) {
            printf("* Layer3 input\n");
        }
        in_h = 4, in_w = 4; in_c = 8; stride = 1; 
        out_h = (in_h - k_h + 2 * padding) / stride + 1;
        out_w = (in_w - k_w + 2 * padding) / stride + 1;
        rows = in_c * k_h * k_w; 
        cols = out_h * out_w;     
        total_elements = rows * cols;
        int32_t *layer3_input = (int32_t *)malloc(total_elements * sizeof(int32_t));
        im2col_32(max_pooling_output_2, in_c, in_h, in_w, k_h, k_w, out_h, out_w, stride, padding, layer3_input);
        for (int i = 0; i < total_elements; i++) {
            layer3_input[i] = (int32_t)(layer3_input[i] / 128.0);
        };
        if (isPrint) {
            print_matrix_32(layer3_input, rows, cols, FALSE);
        }

        // 변환된 결과를 BRAM에 저장
        if (isPrint) {
            printf("\n* Save im2col input to Bram\n");
        }
        save_data_to_multiple_brams_32(layer3_input, rows, cols, conv_before_fc_weights, conv_before_fc_shape[0], conv_before_fc_shape[1]);
        if (isPrint) {
            printf("Complete\n");
        }

        // BRAM에 저장한 데이터를 출력
        if (isPrint) {
            printf("\n* Retrieved im2col output from multiple BRAMs:\n");
            print_to_multiple_brams((conv_before_fc_shape[0] / 4) * (conv_before_fc_shape[1] / 16) * (4 + cols + 15), FALSE);
        }

        // 동적 메모리 해제
        free(col2im_output_2);
        free(layer2_output);
        free(max_pooling_output_2);
        free(layer3_input);

    ////// L3_EN0
        Xil_Out32((XPAR_TOP_0_BASEADDR) + (STATE_OUT_REG*AXI_DATA_BYTE), (u32)(L3_EN_0));
        if (isPrint) {
            printf("\n////////////////////////////// L3_EN0: Ready to calculate layer 3. //////////////////////////////\n"); 
        }
        
    ////// L4_INPUT_BRAM
        do{
            STATE = Xil_In32((XPAR_TOP_0_BASEADDR) + (STATE_IN_REG * AXI_DATA_BYTE));
        } while(STATE != L4_INPUT_BRAM);
        if (isPrint) {
            printf("\n////////////////////////////// L4_INPUT_BRAM: Done Calculation for layer 3. //////////////////////////////\n"); 
        }

        rows = 16;
        cols = 1;
        total_elements = rows * cols;
        int32_t *layer3_output = save_from_bram_out_layer_3(cols);

        if (isPrint) {
            printf("\n* Layer3 output\n");
            print_matrix_32(layer3_output, rows, cols, TRUE);
        }

        if (isPrint) {
            printf("\n* Layer3 output ReLU\n");
        }
        relu(layer3_output, total_elements);
        if (isPrint) {
            print_matrix_32(layer3_output, rows, cols, TRUE);
        }
        for (int i = 0; i < total_elements; i++) {
            layer3_output[i] = (int32_t)(layer3_output[i] / 128.0);
        };

        // 다음 Input을 BRAM에 저장
        if (isPrint) {
            printf("\n* Save layer 4 input to Bram\n");
        }
        save_data_to_multiple_brams_IS(layer3_output, rows, cols, fc_layer_weights, fc_layer_shape[0], fc_layer_shape[1]);
        if (isPrint) {
            printf("Complete\n");
        }

        if (isPrint) {
            printf("\n* Retrieved layer 4 input from multiple BRAMs:\n");
            print_to_multiple_brams(cols + fc_layer_shape[0] + 15, FALSE);
        }

        // 동적 메모리 해제
        free(layer3_output);

    ////// L4_EN0
        Xil_Out32((XPAR_TOP_0_BASEADDR) + (STATE_OUT_REG * AXI_DATA_BYTE), (u32)(L4_EN_0));
        if (isPrint) {
            printf("\n////////////////////////////// L4_EN0: Ready to calculate layer 4. //////////////////////////////\n"); 
        }

    ////// L4_END
        do{
            STATE = Xil_In32((XPAR_TOP_0_BASEADDR) + (STATE_IN_REG * AXI_DATA_BYTE));
        } while(STATE != IDLE);
        if (isPrint) {
            printf("\n////////////////////////////// L4_END: Done Calculation for layer 4. //////////////////////////////\n"); 
        }
        
        rows = 1;
        cols = 10;
        total_elements = rows * cols;
        int32_t *layer4_output = save_from_bram_out_layer_4(cols);

        printf("\n* Layer4 output\n");
        print_matrix_32(layer4_output, rows, cols, TRUE);

        printf("\n* Prediction Result\n");
        print_image(image_data, 28, 28);
        int prediction = find_max_index(layer4_output, rows * cols);
        printf("-> [%s] :: Prediction Result is [%d], and Label is [%d].\n\n", ((prediction == label) ? "Correct" : "Wrong") , prediction, label);

        // 동적 메모리 해제
        free(layer4_output);
    }

    return 0;
}
