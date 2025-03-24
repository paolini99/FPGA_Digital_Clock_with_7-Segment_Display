# ⏰ Digital Clock with Seven-Segment Display

## Project Description  
This project implements a **digital clock** with a **seven-segment display**, operating in a **12-hour format**. The system handles **hours, minutes, and seconds**, supports **manual time adjustment**, and includes an **independent stopwatch** feature.

> ⚙️ The top-level module is **`DE1SOC.v`**, specifically written for the **Terasic DE1-SoC FPGA board**.  
> 📦 All other modules (e.g., counters, decoders, clock dividers) are **generic** and **not DE1-SoC specific**, making them reusable in other FPGA projects.

---

## 🔧 Project Functionality

### ⏳ Time Counting
- Counts time from **00:00:00 to 11:59:59**, then resets automatically.
- Time is displayed on **six seven-segment displays**:
  - **Hours** → `HEX4`, `HEX5`
  - **Minutes** → `HEX2`, `HEX3`
  - **Seconds** → `HEX0`, `HEX1`
- Uses the FPGA's **50 MHz base clock**, divided down to **1 Hz** using a **clock divider**.
- Implements **synchronized modular counters**:
  - **Seconds**: roll over after 60.
  - **Minutes**: roll over after 60.
  - **Hours**: roll over after 12.

### 🎨 Optimized Time Display
- **Leading zero suppression** for hours when below 10 (e.g., `"7:00"` instead of `"07:00"`).
- Managed via a **dedicated display control module** that disables the most significant digit if needed.

### 🧭 Manual Time Adjustment
- **Two push buttons** allow time correction:
  - `KEY[1]` → Increments the hours.
  - `KEY[2]` → Increments the minutes.
- `KEY[0]` performs a **global reset**, setting time back to **00:00:00**.
- A **slow clock pulse** ensures smooth updates during manual adjustment.

---

## ⏱ Stopwatch Extension
- Includes an **independent stopwatch**, toggled via a **mode selector switch** (`SW[0]`).
- Features:
  - **Measures time with hundredths of a second** precision.
  - Operates using a **100 Hz clock** for high-resolution timing.
- Controls:
  - `KEY[1]` → Start/Pause
  - `KEY[2]` → Stop
  - `KEY[0]` → Reset stopwatch to **00:00:00**

---

## 🛠 Technologies Used
- **Verilog HDL** on **FPGA (DE1-SoC board)**
- **Clock Divider** modules for 1 Hz and 100 Hz signals
- **Synchronous modular counters** for time tracking
- **Seven-segment display encoders**
- **Multiplexer** to switch between clock and stopwatch modes

