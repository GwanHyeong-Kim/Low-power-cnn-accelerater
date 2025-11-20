# 🚀 FPGA 기반 저전력 CNN 가속기 설계 프로젝트
**경희대학교 반도체전공트랙 성과발표회 – 최우수상 수상작**

CNN(Convolutional Neural Network) 아키텍처를 설계하고, Google Colab 환경에서 MNIST 데이터셋으로 학습한 뒤  
해당 **학습된 가중치를 FPGA에 적용하여 손글씨 숫자를 인식하는 가속기 애플리케이션을 구현**한 프로젝트입니다.

🔗 **프로젝트 링크:**  
👉 https://github.com/GwanHyeong-Kim/Low-power-cnn-accelerater

---

# 📌 프로젝트 목표

FPGA 기반 CNN 가속기 구조를 직접 설계하고 RTL 수준에서 CNN 연산을 구현하였으며,  
Google Colab에서 학습한 weight를 실제 FPGA 환경에서 적용해 **손글씨 숫자를 실시간으로 추론하는 시스템**을 개발하는 것이 목표였습니다.

---

## 🗓️ 수행 기간
**2024.09.09 ~ 2024.12.04**

---

# 👨‍💻 담당 역할

## 1) CNN 추론 로직 구현 (Verilog)
- CNN의 모든 추론 연산을 PL(Programmable Logic)에서 직접 처리하도록 설계
- Convolution, ReLU, Pooling, Fully Connected Layer를 RTL 단위로 구현
- 연산 구조는 **Systolic Array 기반**으로 설계하고  
  *Weight Stationary / Input Stationary 방식*을 혼합 적용하여 성능 최적화

---

## 2) 인터페이스 설계 (AXI4-Lite)
- PS(ARM Cortex-A9) ↔ PL(FPGA fabric) 간 데이터 전달을 위해 **AXI4-Lite Slave 인터페이스 구현**
- PS에서 image data & CNN weight를 PL로 전달 → CNN 연산 수행 → 결과를 다시 PS로 수신하는 구조 설계

---

## 3) 시스템 통합 및 검증
- Vivado 시뮬레이션 환경에서 CNN RTL 검증 수행
- ZYNQ 보드에서 실제 학습 weight를 적용한 실환경 테스트 수행
- 전체 시스템의 정상 동작을 end-to-end로 검증

---

# 🧰 사용 기술 (HW & SW)

- **Xilinx Vivado**
- **Xilinx Vitis**
- **ZYNQ-7000 SoC (ARM Cortex-A9 + PL)**
- Verilog, AXI4-Lite, CNN inference logic
- Python (dataset preparation, Colab 훈련용)

---

# 📐 프로젝트 개요

## 🔍 1) CNN 추론 모델 (Google Colab)
Colab에서 MNIST 데이터셋을 기반으로 CNN 모델을 학습하여 weight를 확보한 뒤,  
해당 모델 구조를 **Verilog RTL로 변환**하여 FPGA에서 구동 가능하도록 설계하였습니다.

> CNN Architecture 
<img width="534" height="158" alt="스크린샷 2025-11-21 001513" src="https://github.com/user-attachments/assets/ce7b8057-09cb-4855-acb5-cd328b5a4fcf" />

---

## 🔧 2) System Architecture (Block Diagram)
<img width="428" height="236" alt="스크린샷 2025-11-21 001623" src="https://github.com/user-attachments/assets/73e545b3-1f9d-4a94-884b-f0887ce17d0a" />

Colab에서 학습된 weight와 애플리케이션 입력 이미지는 PS에서 PL로 AXI4-Lite를 통해 전달되고,  
PL은 CNN 연산을 수행한 뒤 결과를 다시 PS로 반환합니다.
<img width="428" height="236" alt="스크린샷 2025-11-21 001623" src="https://github.com/user-attachments/assets/7bb25fc2-ab9b-43bf-a97e-7121211f9d8f" />


---

## ⚙️ 3) CNN Systolic Array 구조

CNN Convolution 연산은 PL에서 **Systolic Array** 방식으로 수행되며,
- Weight Stationary (WS)  
- Input Stationary (IS)

두 가지 데이터 흐름 구조를 조합하여 PE 간 데이터 이동을 최소화하고 연산 효율을 극대화했습니다.
<img width="539" height="244" alt="스크린샷 2025-11-21 001702" src="https://github.com/user-attachments/assets/6135cf4d-eb39-40f9-a51c-7e9b0ca81ed7" />



---

# 🎯 주요 기능 및 성능 결과

## ✔ FPGA Implementation Result
<img width="543" height="284" alt="스크린샷 2025-11-21 001712" src="https://github.com/user-attachments/assets/be2e775d-d459-47d4-8e39-e1b2e3dffa7b" />


- **정확도:** MNIST 기준 **96.7% 달성**  
- **속도:** ARM Cortex-A9 대비 **1.7× 빠른 추론 성능**  
- **면적 최적화:** 곱셈 기반 CNN 대비 **30% FPGA Logic 면적 절감**

---

## ✔ 손글씨 인식 Application 개발

<img width="430" height="299" alt="스크린샷 2025-11-21 001722" src="https://github.com/user-attachments/assets/20f295e7-b085-4ee6-9651-fa1f9a9453ba" />


사용자가 숫자를 그리면  
→ PS가 image data를 PL로 전달  
→ PL에서 CNN 추론 수행  
→ 결과를 PS가 받아 화면에 출력하는 구조로 애플리케이션 구현

---

## 🏆 수상 
본 프로젝트로 **반도체전공트랙 성과발표회 최우수상**을 수상하였습니다.

---

# 🐞 트러블슈팅 (문제 상황 → 원인 분석 → 해결 과정)

## 🔻 문제 상황
시뮬레이션에서는 정상 동작하였으나,  
실제 FPGA 보드에서는 **특정 AXI4-Lite Slave Register의 Write/Read가 동작하지 않는 문제** 발생.

---

## 🔍 문제 원인 분석
- AXI4-Lite 인터페이스에 **ILA(Integrated Logic Analyzer)** 삽입  
- 동작 중 WADDR, RADDR, WDATA, WVALID 신호를 캡처  
- 특정 레지스터의 WADDR/RADDR이 **4 Byte alignment 규칙을 만족하지 않음**을 확인 (4의 배수가 아님)

---

## ✔ 해결 방안
- Register offset mapping을 문서화  
- C 코드 및 RTL에서 동일한 주소 맵을 참조하도록 구조 정리  
- 이후 모든 AXI 통신 정상 동작 확인

---

# ✨ 고찰

본 프로젝트를 통해 **소프트웨어 기반 CNN 모델을 실제 하드웨어 구조로 변환하는 전 과정**을 직접 경험할 수 있었습니다.  
Systolic Array 기반 Convolution 최적화, PS–PL 간 AXI 인터페이스 설계, 실제 FPGA 동작 디버깅(ILA) 등  
딥러닝 가속기 설계의 핵심 요소들을 체계적으로 이해할 수 있었습니다.

특히 시뮬레이션과 FPGA 사이에서 발생하는 동작 차이를 ILA로 분석하여 해결하는 과정에서  
**시스템 레벨 디버깅 역량**을 크게 향상시킬 수 있었습니다.
