<p align="center">
  <h1 align="center">De2 보드를 활용한 디지털시계✨</h1>
</p>

## Index ⭐
 - [1. Spec](#1-spec)
 - [2. 기본 기능](#2-기본-기능)
   - [2-1. 전체 블록 다이어그램](#2-1-전체-블록-다이어그램)
   - [2-2. Display Format - 7 Segment](#2-2-Display-Format---7-Segment)
   - [2-3. X100 Faster Debug](#2-3-X100-Faster-Debug)
   - [2-4. Digitclock](#2-4-Digitclock)
   - [2-5. Manual Clock Setting](#2-5-Manual-Clock-Setting)
   - [2-6. Stopwatch](#2-6-Stopwatch)
   - [2-7. Debounce](#2-7-Debounce)
 - [3. 추가 기능](#3-추가-기능)
   - [3-1. 밝기 조절](#3-1-밝기-조절)
   - [3-2. 노크 알람](#3-2-노크-알람)
   - [3-3. 화재 경보](#3-3-화재-경보)
 - [4. Utility](#4-utility)
   - [4-1. 면적 감소 아이디어](#4-1-면적-감소-아이다어)
   - [4-2. Utility 결과](#4-2-utility-결과)

## 1. Spec
- 8개의 7SEGs - 날짜 (31일 고정!) - 시간 (24시간) - 분 - 초 형식
- 디버깅을 위한 100배 가속 기능
- 50MHz 레퍼런스 Clock 사용 -> Generate 1kHz -> 1kHz 기준으로 적용
- Asynchronous Reset negative (SW0)
- Manual Timing Setting
  - 해당 모드 진입 (SW1 On), KEY3 누를 시, 초 -> 분 -> 시간 -> 날짜 -> 초 순서로 이동
  - KEY2는 1씩 증가, KEY1은 1씩 감소
  - SW1 Off 시, 표시되던 7SEGs가 업데이트 되어서 정상 Digital Clock이 표시 되어야 함.
- Stop Watch
  - 해당 모드 진입 (SW2 On), KEY3 누르면 시작, 다시 KEY3 누르면 정지, SW Off 시 Reset.
  - 이 기능은 Main Clock에 영향을 주면 안됨. 즉, Stop Watch Mode 일 때, Digital Clock은 동작 중이어야 함.
 
### Additional Spec
- 센서를 활용한 3개의 추가 기능
- Pomodoro 금지!

### Score (80%(기능), 20%(발표))
- 기능 : 각 기능 (20pt), 각 추가 기능 (5pt)
- 발표 : Block Diagram + Utility + 3 Additional Specs. (15pt) + 10분 제한 (5pt)
- Utility : 추가 기능 포함 (5pt)
 
## 2. 기본 기능
### 2-1. 전체 블록 다이어그램
<p align="center">
  <img width="100%" alt="전체 블록 다이어그램" src="https://github.com/user-attachments/assets/5223b592-d450-4de8-b754-51a52c98dad2" />
</p>

### 1-2. Display Format - 7 Segment
<table>
  <tr>
    <td align="center" width="60%"><img width="100%" alt="7 Segment Schematic" src="https://github.com/user-attachments/assets/c007cf7f-9294-4c44-98c8-0f998f238547" /></td>
    <td width="40%">
      
``` verilog
module DISPLAY7SEG(/*AUTOARG*/
            // Outputs
            SEG,
            // Inputs
            OUT, PWM_ACT
            );
  input [3:0] OUT;
  input PWM_ACT;
  output reg [6:0] SEG;
  // Internal signlal declarations

  // Combinational logic
  always @(*) begin
    case (OUT)
  4'h0 : SEG = (PWM_ACT) ? 7'b1000000 : 7'b1111111;
  4'h1 : SEG = (PWM_ACT) ? 7'b1111001 : 7'b1111111;
  4'h2 : SEG = (PWM_ACT) ? 7'b0100100 : 7'b1111111;
  4'h3 : SEG = (PWM_ACT) ? 7'b0110000 : 7'b1111111;
  4'h4 : SEG = (PWM_ACT) ? 7'b0011001 : 7'b1111111;
  4'h5 : SEG = (PWM_ACT) ? 7'b0010010 : 7'b1111111;
  4'h6 : SEG = (PWM_ACT) ? 7'b0000010 : 7'b1111111;
  4'h7 : SEG = (PWM_ACT) ? 7'b1111000 : 7'b1111111;
  4'h8 : SEG = (PWM_ACT) ? 7'b0000000 : 7'b1111111;
  4'h9 : SEG = (PWM_ACT) ? 7'b0010000 : 7'b1111111;
  default : SEG = 7'b1111111;
    endcase
  end
endmodule
```

  </td>
  </tr>
</table>

### 2-3. X100 Fast Debug

<table>
  <tr>
    <td align="center" width="60%"><img width="100%" alt="X100 Fast Debug Schematic" src="https://github.com/user-attachments/assets/04537041-5c13-45fb-9c2f-7539a9bec667" /></td>
    <td width="40%">
    <strong>각 Module에 SW3을 조건으로 100배 디버그 기능</strong><br/><br/>

``` verilog
//...
    if (SW3) begin
      next_cnt = (CNT>= 10'd9) ? 10'd0 : CNT + 10'd1;
      next_en = (CNT >= 10'd9) ? 1'd1 : 1'd0;
    end
    else begin
      next_cnt = (CNT == 10'd999) ? 10'd0 : CNT + 10'd1;
      next_en = (CNT == 10'd999) ? 1'd1 : 1'd0;
    end
//...
```

  </td>
  </tr>
</table>

### 2-4. Digitclock

``` verilog
//...
   BCDCNTR #(.MAXL(4'h3), .MAXR(4'h1), .SETL(4'h0), .SETR(4'h1))
   UDAY (/*AUTOINST*/
	 // Outputs
	 .BCD				(NORMAL_DAY),
	 .CARRY				(CARRY_DAY),
	 // Inputs
	 .CLK1K				(CLK1K),
	 .RSTN				(RSTN),
	 .EN				(CARRY_HOUR),
	 .SW1				(SW1),
	 .BCD_SET			(DAY_SET));

   BCDCNTR #(.MAXL(4'h2), .MAXR(4'h3), .SETL(4'h0), .SETR(4'h0))
   UHOUR (/*AUTOINST*/
	  // Outputs
	  .BCD				(NORMAL_HOUR),
	  .CARRY			(CARRY_HOUR),
	  // Inputs
	  .CLK1K			(CLK1K),
	  .RSTN				(RSTN),
	  .EN				(CARRY_MIN),
	  .SW1				(SW1),
	  .BCD_SET			(HOUR_SET));
   
   BCDCNTR #(.MAXL(4'h5), .MAXR(4'h9), .SETL(4'h0), .SETR(4'h0))
   UMIN (/*AUTOINST*/
	 // Outputs
	 .BCD				(NORMAL_MIN),
	 .CARRY				(CARRY_MIN),
	 // Inputs
	 .CLK1K				(CLK1K),
	 .RSTN				(RSTN),
	 .EN				(CARRY_SEC),
	 .SW1				(SW1),
	 .BCD_SET			(MIN_SET));
   
   BCDCNTR #(.MAXL(4'h5), .MAXR(4'h9), .SETL(4'h0), .SETR(4'h0))
   USEC (/*AUTOINST*/
	 // Outputs
	 .BCD				(NORMAL_SEC),
	 .CARRY				(CARRY_SEC),
	 // Inputs
	 .CLK1K				(CLK1K),
	 .RSTN				(RSTN),
	 .EN				(EN),
	 .SW1				(SW1),
	 .BCD_SET			(SEC_SET));
//...
```

``` verilog
module BCDCNTR #(parameter MAXL = 4'h5, parameter MAXR = 4'h9, parameter SETL = 4'h0, parameter SETR = 4'h0)(/*AUTOARG*/
													     // Outputs
													     BCD, CARRY,
													     // Inputs
													     CLK1K, RSTN, EN, SW1, BCD_SET
													     );
   input CLK1K, RSTN, EN, SW1; // Text other ports
   input [7:0] BCD_SET;
   output reg [7:0] BCD;
   output reg 	    CARRY;
   // Internal signal declarations
   reg [3:0] 	    next_left_bcd, next_right_bcd;
   reg 		    next_carry;
//...
```

- **BCD Counter를 이용하여 기본기능의 시계를 구현**
- **Parameter를 이용하여 날짜, 시, 분, 초의 MIN, MAX를 설정**

<p align="center">
  <img width="100%" alt="Digitclock Schematic" src="https://github.com/user-attachments/assets/e34a9f32-4285-438a-8d36-862e1773389e" />
</p>

## 2-5. Manual Clock Setting

<table>
  <tr>
    <td align="center" width="70%">
      <img width="100%" alt="Manual Clock Setting Schematic" src="https://github.com/user-attachments/assets/e63bc933-7975-45a9-adf3-d92e3efb82b3" />
    </td>
    <td width="30%">
  
``` verilog
module BCDCNTR #(parameter MAXL = 4'h5, parameter MAXR = 4'h9, ...
   input CLK1K, RSTN, EN, SW1; // Text other ports
   input [7:0] BCD_SET;
   output reg [7:0] BCD;
   output reg 	    CARRY;
   // Internal signal declarations
   reg [3:0] 	    next_left_bcd, next_right_bcd;
   reg 		    next_carry;

   // Sequential logic
   always @(posedge CLK1K or negedge RSTN) begin
      if (!RSTN) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 BCD <= {SETL, SETR};
	 CARRY <= 1'h0;
	 // End of automatics
      end
      else begin
	 if (SW1) begin
	    BCD <= BCD_SET;
	    CARRY <= next_carry;
	 end
	 else begin
	    BCD <= {next_left_bcd, next_right_bcd};
	    CARRY <= next_carry;
	 end
      end
   end
```

  </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <img width="100%" alt="Manual Clock Setting Schematic 2" src="https://github.com/user-attachments/assets/473ed349-e87b-4030-9795-d706b820d190" />
    </td>
  </tr>
</table>

### 2-6. Stopwatch

<table>
  <tr>
    <td align="center" width="50%">
      <img width="100%" alt="Stopwatch Schematic 1" src="https://github.com/user-attachments/assets/55ed2c5b-6d94-4fb8-a815-f58e64507e42" />
    </td>
    <td align="center" width="50%">
      <img width="100%" alt="Stopwatch Schematic 2" src="https://github.com/user-attachments/assets/ebdc71c9-b68b-49a8-affe-60c23ca549b2" />
    </td>
  </tr>
  <tr>
    <td colspan="2">

``` verilog
//...
  assign DAY = (SW2 == 1'b1) ? SW_DAY : NORMAL_DAY;
  assign HOUR = (SW2 == 1'b1) ? SW_HOUR : NORMAL_HOUR;
  assign MIN = (SW2 == 1'b1) ? SW_MIN : NORMAL_MIN;
  assign SEC = (SW2 == 1'b1) ? SW_SEC : NORMAL_SEC;
//...
```
      
  </tr>
  <tr>
    <td colspan="2" align="center">
      <img width="100%" alt="Stopwatch Schematic 3" src="https://github.com/user-attachments/assets/bdb98c25-9c64-4311-89b9-401cfb47d565" />
    </td>
  </tr>
</table>

### 2-7. Debounce
<table>
  <tr>
    <td rowspan="2" align="center" width="40%">
      <img width="100%" alt="Debounce Schematic" src="https://github.com/user-attachments/assets/991f7cbf-767a-4401-aabb-1660b9f4cad1" />
    </td>
    <td align="center" width="60%">
      <img width="100%" alt="Debounce Waveform KEY" src="https://github.com/user-attachments/assets/f1d3b272-81b3-4f27-93a8-e07c6672ad0e" />
      <strong>Debounce KEY</strong>
    </td>
  </tr>
  <tr>
    <td align="center" width="60%">
      <img width="100%" alt="Debounce Waveform SW" src="https://github.com/user-attachments/assets/fa1a2435-60b7-49f8-8329-da5627473c3f" />
      <strong>Debounce SW</strong>
    </td>
  </tr>
</table>

## 3. 추가 기능
### 3-1. 밝기 조절
<table align="center">
  <tr>
    <td align="center" width="40%"><img width="60%" alt="Rotary Encoder" src="https://github.com/user-attachments/assets/9cf09677-178b-4f5e-8f36-d0a06b24d7c9" /></td>
    <td width="60%">
      <ul>
        <li>로터리 엔코더(KY-040)를 사용하여 7-Segment Display 밝기 조절</li>
        <li>PWM 값 증감을 통한 디스플레이 밝기 제어</li>
        <li>로터리 엔코더로 PWM 신호 조절</li>
      </ul>
    </td>
  </tr>
</table>

<p align="center">
  <img width="60%" alt="PWM Schematic" src="https://github.com/user-attachments/assets/9e002d77-0b18-4359-8b75-b2d91a97a22f" />
</p>

``` verilog
//...
		if (SW5) begin
      case ({prev_state, current_state}) // Rotary Encoder가 오른쪽으로 회전시 PWM +
        4'b0001, 4'b0111, 4'b1110, 4'b1000: begin
           if (brightness <= 8'd247)
             brightness <= brightness + 8'd8;
           else
             brightness <= 8'd255;
        end
        4'b0010, 4'b0100, 4'b1101, 4'b1011: begin // Rotary Encoder가 왼쪽으로 회전시 PWM -
           if (brightness >= 8'd8)
             brightness <= brightness - 8'd8;
           else
             brightness <= 8'd0;
        end
        default: brightness <= brightness;
      endcase
		end
		else begin
			brightness <= brightness;
		end
      prev_state <= current_state;
		end
   end
//...
```

### 3-2. 노크 알람
<table align="center">
  <tr>
    <td align="center" width="40%"><img width="60%" alt="Knock" src="https://github.com/user-attachments/assets/f4a3f415-cacd-4fb4-bd24-aa523cdfd79c" /></td>
    <td width="60%">
      <ul>
        <li>노크 센서(KY-031)와 부저(KY-006)를 이용한 알람 기능</li>
        <li>노크 횟수에 따라 알람 시간 증가</li>
        <li>남은 시간 LED 표시, 알람 시 부저 울림</li>
      </ul>
    </td>
  </tr>
</table>

<table align="center">
  <tr>
    <td align="center">
      <img width="100%" alt="Knock Schematic" src="https://github.com/user-attachments/assets/db53e15e-3f4b-4e7e-b256-119269475b19" />
    </td>
  </tr>
  <tr>
    <td>
      
``` verilog
//...
  if (KNOCK_FALL) begin
    next_timer_en = 1'b1;
    next_min_remain = (MIN_REMAIN < 5'd19) ? MIN_REMAIN + 5'd1 : MIN_REMAIN;
//...
```

  </td>
  </tr>
  <tr>
    <td>
      <ul>
        <li>알람 카운트가 끝나면 부저 울림</li>
        <li>남은 시간 1분 마다 LED 1개 점등</li>
        <li>노크 1회당 알람 1분 증가</li>
      </ul>
    </td>
  </tr>
</table>

### 3-3. 화재 경보
<table align="center">
  <tr>
    <td align="center" width="40%"><img width="100%" alt="Fire" src="https://github.com/user-attachments/assets/403a1c5f-89ae-4dce-b248-40d6fea404aa" /></td>
    <td width="60%">
      <ul>
        <li>불꽃 감지 센서(KY-026)를 이용한 화재 경보</li>
        <li>화재 감지 시 초록색 LED 점등 및 부저 울림</li>
        <li>신속한 화재 인지 및 경고</li>
      </ul>
    </td>
  </tr>
</table>

<p align="center">
  <img width="29%" alt="Fire Schematic 1" src="https://github.com/user-attachments/assets/755dfe27-9237-4bf2-9209-968e1e0e558f" />
  <img width="69%" alt="Fire Schematic 2" src="https://github.com/user-attachments/assets/08ff3cc4-5c16-4c52-b2bd-e4d7b9ec3e49" />
</p>

- 화재가 감지되면 Knock 신호가 들어올 때까지 부저가 울림
- 화재 경보 모듈은 노크 알람 모듈보다 우선 순위

## 4. Utility
### 4-1. 면적 감소 아이디어
#### 모듈 재사용(Modular Reuse)
- 동일한 기능을 수행하는 하위 모듈 (`DISPLAY7SEG`, `DEBOUNCE`, `BCDCNTR`) 등을 파라미터나 입력에 따라 여러 인스턴스에서 재활용.(로직 복잡도를 줄이고 합성 시 회로 최적화를 유도.)
- `SEGx` 출력도 하나의 `DISPLAY7SEG` 디코더 로직을 재사용, 복잡한 디코딩 로직 없이 단일 자릿수 변환만 수행할 수 있게 함.

#### Bit Shift 연산으로 Case문 최소화
- 추가 기능을 구현할 때, LED 점등 출력 시 `MIN_REMAIN` 값에 따른 복잡한 Case문 대신, Shift 연산과 간단한 뺄셈 연산을 이용하여 논리 회로의 복잡도를 줄였으며, Schematic에서도 불필요한 MUX를 줄여 회로 면적을 최적화 함.

``` verilog
//...
  next_led = (MIN_REMAIN == 5'd0) ? 18'd0 : (18'b1 << MIN_REMAIN) - 18'b1;
//...
```

<table align="center">
  <tr>
    <td align="center"><img width="100%" alt="Shift Schematic" src="https://github.com/user-attachments/assets/1cd76ed4-a32c-4b56-953a-d2de9d4c4fef" /></td>
    <td align="center"><img width="100%" alt="MUX Schematic" src="https://github.com/user-attachments/assets/5473ce01-a1ec-4b07-b13b-ebc0a9772648" /></td>
  </tr>
  <tr>
    <td align="center"><strong>Shift 연산 + Subtract 방식으로 처리한 경우(현재)</strong></td>
    <td align="center"><strong>Case문으로 처리한 경우</strong></td>
  </tr>
</table>

#### Sequential Logic과 Combinational Logic 분리
- 사실 면적 최적화는 아니고, Tool이 더 잘 알아볼 수 있도록 분리 시킴.
- 모든 주요 모듈(BCDCNTR, SW_BCDCNTR, DIGITCLOCK, STOPWATCH 등)에서
  - Sequential Block : 레지스터(상태, 출력)의 업데이트만 수행
  - Combinational Block : 모든 조건 판단과 연산 수행

&nbsp;이를 통해 Register Transfer Logic을 수행하고, 합성 시 Logic Sharing과 Timing Optimization이 더욱 효율적으로 이루어지도록 작성.

``` verilog
// Sequential Logic
always @(posedge CLK1K or negedge RSTN) begin
  if (!RSTN) begin
    BCD <= {SETL, SETR};
    CARRY <= 1'b0;
  end
  else begin
    if (SW1) begin
      BCD <= BCD_SET;
      CARRY <= next_carry;
    end
    else begin
      BCD <= {next_left_bcd, next_right_bcd};
      CARRY <= next_carry;
    end
  end
end

// Combinational Logic
always @(*) begin
  if (EN) begin
    ...
  ense
end
```

### 4-2. Utility 결과
<table align="center">
  <tr>
    <td align="center" width="70%"><img width="100%" alt="Utility Result" src="https://github.com/user-attachments/assets/aaec924b-6e62-49fa-a33c-dd1d1f78c53d" /></td>
    <td width="30%">
      <table>
          <tr><th>항목</th><td>Gate Count (%)</td></tr>
          <tr><th>Total logic elements</th><td>2.31 %</td></tr>
          <tr><th>Total combinational functions</th><td>2.29 %</td></tr>
          <tr><th>Dedicated logic registers</th><td>0.98 %</td></tr>
          <tr><th>Average</th><td><strong>1.86 %</strong></td></tr>
      </table>
</table>

