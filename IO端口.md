# LXB_DEMO

### npc.v

| 端口名称     | 方向 | 功能描述                           |
| ------------ | ---- | ---------------------------------- |
| PC[31:0]     | I    | PC寄存器的值                       |
| PC4_D[31:0]  | I    |                                    |
| IR26_D[25:0] | I    |                                    |
| RF_RS[31:0]  | I    |                                    |
| PC_BP[31:0]  | I    |                                    |
| BP_WR        | I    | BP预测是否错误                     |
| NPC_CTR[1:0] | I    | 00:PC+8 01:im16 10:im26 11:GRF[rs] |
| NPC[31:0]    | O    | 可能时NPC的NPC(当b、j指令时)       |
| NPC_01[31:0] | O    | PC_B                               |

### pc.v

| 端口名称    | 方向 | 功能描述 |
| ----------- | ---- | -------- |
| clk         | I    | 时钟信号 |
| reset       | I    | 复位信号 |
| en          | I    | 使能端   |
| PC4_F[31:0] | I    |          |
| PC[31:0]    | O    |          |

### add.v

| 端口名称    | 方向 | 功能描述 |
| ----------- | ---- | -------- |
| PC_F[31:0]  | I    |          |
| PC4_F[31:0] | O    |          |

### im_ip.v

| 端口名称    | 方向 | 功能描述   |
| ----------- | ---- | ---------- |
| clk         | I    | 时钟信号   |
| reset       | I    | 复位信号   |
| ren         | I    | 读使能     |
| addr[31:0]  | I    | 地址       |
| rdata[31:0] | O    | 读出的数据 |

### reg_flow.v

| 端口名称                           | 方向 | 功能描述       | FT   | TD   | DE   | EM   | MR   | RW   |
| ---------------------------------- | ---- | -------------- | ---- | ---- | ---- | ---- | ---- | ---- |
| clk                                | I    | 时钟信号       | 1    | 1    | 1    | 1    | 1    | 1    |
| reset                              | I    | 复位信号       | 1    | 1    | 1    | 1    | 1    | 1    |
| clr                                | I    | 清零信号       | 1    | 1    | 1    | 1    | 1    | 1    |
| en                                 | I    | 使能信号       | 1    | 1    | 1    | 1    | 1    | 1    |
| PC_I[31:0]                         | I    | 当前指令的PC   | 1    | 1    | 1    | 1    | 1    | 1    |
| PC4_I[31:0]                        | I    | 当前指令的PC+4 | 1    | 1    | 1    | 1    | 1    | 1    |
| PC8_I[31:0]                        | I    | 当前指令的PC+8 |      | 1    | 1    | 1    | 1    | 1    |
| IR_I[31:0]                         | I    | 当前指令       |      | 1    | 1    | 1    | 1    | 1    |
| RF_RS_I[31:0]                      | I    | GRF[rs]        |      |      | 1    |      |      |      |
| RF_RT_I[31:0]                      | I    | F              |      |      | 1    | 1    |      |      |
| IMM_EXT_I[31:0]                    | I    | 扩展后的立即数 |      |      | 1    |      |      |      |
| RES_ALU_I[31:0]                    | I    | ALU的计算结果  |      |      |      | 1    | 1    | 1    |
| RDATA_I[31:0]                      | I    | DM读出的数据   |      |      |      |      |      | 1    |
| Data_Hazard_I[44:0]                | I    | 你懂得         |      |      | 1    | 1    | 1    | 1    |
| A3_I[4:0]                          | I    |                |      |      |      |      |      |      |
| PC_O[31:0]                         | O    | 当前指令的PC   |      |      |      |      |      |      |
| PC4_O[31:0]                        | O    | 当前指令的PC+4 |      |      |      |      |      |      |
| PC8_O[31:0]                        | O    | 当前指令的PC+8 |      |      |      |      |      |      |
| IR_O[31:0]                         | O    | 当前指令       |      |      |      |      |      |      |
| RF_RS_O[31:0]                      | O    | GRF[rs]        |      |      |      |      |      |      |
| RF_RT_O[31:0]                      | O    | F              |      |      |      |      |      |      |
| IMM_EXT_O[31:0]                    | O    | 扩展后的立即数 |      |      |      |      |      |      |
| RES_ALU_O[31:0]                    | O    | ALU的计算结果  |      |      |      |      |      |      |
| RDATA_O[31:0]                      | O    | DM读出的数据   |      |      |      |      |      |      |
| Data_Hazard_O[34:0]                | O    | 你懂得         |      |      |      |      |      |      |
| A3_O[4:0]                          | O    |                |      |      |      |      |      |      |
| some control signals in controller | IO   |                |      |      |      |      |      |      |

### grf.v

| 端口名称  | 方向 | 功能描述  |
| --------- | ---- | --------- |
| clk       | I    | 时钟信号  |
| reset     | I    | 复位信号  |
| PC[31:0]  | I    | PC        |
| A1[4:0]   | I    | 读地址1   |
| A2[4:0]   | I    | 读地址2   |
| A3[4:0]   | I    | 写地址    |
| WD3[31:0] | I    | 写数据    |
| WEN       | I    | 写使能    |
| RD1[31:0] | O    | 读出数据1 |
| RD2[31:0] | O    | 读出数据2 |

### ext.v

| 端口名称      | 方向 | 功能描述       |
| ------------- | ---- | -------------- |
| imm[15:0]     | I    | 十六位立即数   |
| EXT_CTR[1:0]  | I    | 扩展方式控制   |
| imm_ext[31:0] | O    | 扩展后的立即数 |

### cmp.v

| 端口名称 | 方向 | 功能描述     |
| -------- | ---- | ------------ |
| D1[31:0] | I    | 第一个比较数 |
| D2[31:0] | I    | 第二个比较数 |
| EQ       | O    | 是否相等     |

### controller.v

| 端口名称     | 方向 | 功能描述                                                     | DE                                                   | EM                                                   | MR                                                   | RW                                                   |
| ------------ | ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| IR[31:0]     | I    | 要解析的指令                                                 |                                               |                                                  |                                                  |                                                  |
| BP                | I    | BPU预测结果                                                  |                                                   |                                                   |                                                   |                                                   |
| NPC_CTR[1:0] | O    | NPC的选择 <br />00:PC+4 <br />01:im16 <br />10:im26 <br />11:GRF[rs] |  |  |  |  |
| EXT_CTR[1:0] | O    | 立即数的扩展方式 <br />00:零扩展 <br />01:符号扩展 <br />10:后加16个0 |  |  |  |  |
| ALUB_SEL     | O    | 选择ALU的第二个操作数 <br />0:GRF[rt] <br />1:imm            | 1           |             |             |             |
| ALU_CTR[4:0] | O    | 控制ALU的运算行为 <br />00000:and <br />00001:or <br />00010:+ <br />00110:- | 1 |  |  |  |
| DM_REN       | O    | DM读使能                                                     | 1                                                    | 1                                                   |                                                      |                                                      |
| DM_WEN       | O    | DM写使能                                                     | 1                                                    | 1                                                    |                                                      |                                                      |
| A3_SEL[1:0]  | O    | 00:rt <br />01:rd <br />10:0x1f                              |      |      |      |                              |
| WD3_SEL[1:0] | O    | 00:ALU_RES <br />01:DM <br />10:PC+8                         | 1                        | 1                        | 1                        | 1                        |
| REG_WEN    | O | grf写使能 | 1 | 1 | 1 | 1 |
| Data_Hazard[34:0] | O | {Tuse1, Tuse2, grf1, grf2, grfchange, Tnew, WD3} | 1 | 1 | 1 | 1 |

### alu.v

| 端口名称      | 方向 | 功能描述     |
| ------------- | ---- | ------------ |
| ALU_CTR[4:0]  | I    | ALU操作控制  |
| SrcA[31:0]    | I    | 第一个操作数 |
| SrcB[31:0]    | I    | 第二个操作数 |
| RES_ALU[31:0] | O    | ALU操作结果  |

### dm_ip.v

| 端口名称    | 方向 | 功能描述 |
| ----------- | ---- | -------- |
| clk         | I    | 时钟信号 |
| reset       | I    | 复位信号 |
| PC          |      |          |
| wen         | I    | 写使能   |
| wdata[31:0] | I    | 写入数据 |
| ren         | I    | 读使能   |
| addr[31:0]  | I    | 读地址   |
| rdata[31:0] | O    | 读出数据 |

### mux_normal.v

| 端口名称      | 方向 | 功能描述            |
| ------------- | ---- | ------------------- |
| IR_D[31:0]    | I    | D级指令             |
| A3_SEL[1:0]   | I    | A3_SEL              |
| A3[4:0]       | O    | A3                  |
| RF_RT[31:0]   | I    | GRF[RT]             |
| imm_ext[31:0] | I    | 扩展后的立即数      |
| ALUB_SEL      | I    | ALUB_SEL            |
| ALUB[31:0]    | O    | ALUB |
| RDATA[31:0]   | I    | DM读出数据          |
| RES_ALU[31:0] | I    | ALU计算结果         |
| PC8_W[31:0]   | I    | W级的PC+8           |
| WD3_SEL[1:0]  | I    | 选择要写到grf的数据 |
| WD3[31:0]     | O    | WD3 |

### hazard.v

| 端口名称     | 方向 | 功能描述      |
| ------------ | ---- | ------------- |
| Data_D[34:0] | I    | Data_Hazard_D |
| Data_E[34:0] | I    | Data_Hazard_E |
| Data_M[34:0] | I    | Data_Hazard_M |
| Data_R[34:0] | I    | Data_Hazard_R |
| Data_W[34:0] | I    | Data_Hazard_W |
| F_RS_D[2:0]  | O    | RS_D转发控制  |
| F_RT_D[2:0]  | O    | RT_D转发控制  |
| F_RS_E[2:0]  | O    | RS_E转发控制  |
| F_RT_E[2:0]  | O    | RT_E转发控制  |
| F_RT_M[2:0]  | O    | RT_M转发控制  |
| Stall_PC     | O    |               |
| Stall_T      | O    |               |
| Stall_D      | O    |               |
| Flush_E      | O    | 冲刷E级流水   |

### bpu.v

| 端口名称    | 方向 | 功能描述                 |
| ----------- | ---- | ------------------------ |
| clk         | I    | 时钟信号                 |
| reset       | I    | 复位信号                 |
| clr         | I    | 清除所有寄存器           |
| stall       | I    |                          |
| IR_D[31:0]  | I    |                          |
| EQ          | I    | CMP比较结果              |
| PC[31:0]    | I    |                          |
| PC_B[31:0]  | I    |                          |
| BP          | O    | 预测是否跳转             |
| PC_BP[31:0] | O    | 错误预测之后的输出正确PC |
| BP_WR       | O    | 预测错误                 |
| TD_STALL    | O    |                          |

### mux_forward.v

| 端口名称       | 方向 | 功能描述                                                     |
| -------------- | ---- | ------------------------------------------------------------ |
| **RD1[31:0]**  | I    | grf.RD1                                                      |
| PC8_E[31:0]    | I    |                                                              |
| PC8_M[31:0]    | I    |                                                              |
| PC8_R[31:0]    | I    |                                                              |
| AO_M[31:0]     | I    |                                                              |
| AO_R[31:0]     | I    |                                                              |
| F_RS_D[2:0]    | I    | 3'b000: RD1<br />3'b001: PC8_E<br />3'b010: PC8_M<br />3'b011: AO_M<br />3'b100: PC8_R<br />3'b101: AO_R |
| MF_RS_D[31:0]  | O    | 转发后的RS_D                                                 |
| **RD2[31:0]**  | I    | grf.RD2                                                      |
| F_RT_D[2:0]    | I    | 3'b000: RD2<br />3'b001: PC8_E<br />3'b010: PC8_M<br />3'b011: AO_M<br />3'b100: PC8_R<br />3'b101: AO_R |
| MF_RT_D[31:0]  | O    | 转发后的RT_D                                                 |
| **RS_E[31:0]** | I    |                                                              |
| WD3[31:0]      | I    |                                                              |
| F_RS_E[2:0]    | I    | 3'b000: RS_E<br />3'b001: PC8_M<br />3'b010: AO_M<br />3'b011: PC8_R<br />3'b100: AO_R<br />3'b101: WD3<br /> |
| MF_RS_E[31:0]  | O    |                                                              |
| **RT_E[31:0]** | I    |                                                              |
| F_RT_E[2:0]    | I    | 3'b000: RT_E<br />3'b001: PC8_M<br />3'b010: AO_M<br />3'b011: PC8_R<br />3'b100: AO_R<br />3'b101: WD3 |
| MF_RT_E[31:0]  | O    |                                                              |
| RT_M[31:0]     | I    |                                                              |
| F_RT_M[2:0]    | I    | 3'b000: RT_M<br />3'b001: PC8_R<br />3'b010: AO_R<br />3'b011: WD3 |
| MF_RT_M[31:0]  | O    |                                                             |

### cpu.v

| 端口名称              | 方向 | 功能描述 |
| --------------------- | ---- | -------- |
| clk                   | I    | 时钟信号 |
| reset                 | I    | 复位信号 |
| inst_sram_en[31:0]    | O    |          |
| inst_sram_wen[31:0]   | O    |          |
| inst_sram_addr[31:0]  | O    |          |
| inst_sram_wdata[31:0] | O    |          |
| inst_sram_rdata[31:0] | I    |          |
| data_sram_en[31:0]    | O    |          |
| data_sram_wen[31:0]   | O    |          |
| data_sram_addr[31:0]  | O    |          |
| data_sram_wdata[31:0] | O    |          |
| data_sram_rdata[31:0] | I    |          |

### be.v

| 端口名称      | 方向 | 功能描述       |
| ------------- | ---- | -------------- |
| addr[1:0]     | I    |                |
| MF_RT_M[31:0] | I    |                |
| S_SEL[1:0]    | I    | 00:W 01:H 10:B |
| rdata[31:0]   | O    |                |
| BE[3:0]       | O    |                |

### ld_ext.v

| 端口名称       | 方向 | 功能描述 |
| -------------- | ---- | -------- |
| addr[1:0]      | I    |          |
| rdata_dm[31:0] | I    |          |
| LD_CTR[2:0]    | I    |          |
| rdata[31:0]    | O    |          |

### check.v

| 端口名称      | 方向 | 功能描述 |
| ------------- | ---- | -------- |
| PC_M[31:0]    | I    |          |
| SL_Addr[31:0] | I    |          |
| RI            | I    |          |
| syscall       | I    |          |
| break         | I    |          |
| Over          | I    |          |
| Exc           | O    |          |
| ExcCode[4:0]  | O    |          |

### cp0.v

| 端口名称     | 方向 | 功能描述 |
| ------------ | ---- | -------- |
| PC_M[31:0]   | I    |          |
| Addr[31:0]   | I    |          |
| HW[5:0]      | I    |          |
| eret         | I    |          |
| BD           | I    |          |
| ExcCode[6:2] | I    |          |
| A[4:0]       | I    |          |
| WEN          | I    |          |
| WD[31:0]     | I    |          |
| RD[31:0]     | O    |          |
| EPC[31:0]    | O    |          |
| IntReq       | O    |          |

