;**********************MASK2:工艺参数_批量_基本:panel_2:;**********************
//M(Mask2/$85021/"panel_2_0_chs.png"/)

	;DEF TECH_PAR_VAR1=(R/%TECH_PAR1///WR1////3,30,115,30)
	;DEF TECH_GRID_VAR=(R/%TECH_GRID///WR2////115,51,360,210)
	
	;前后砂轮选择
	DEF VAR10=(I/*0=$85233,1=$85234//$85203,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[111]"/0,0,0/132,78,60//"UserGuide/section_2.html","S2D3");
	DEF VAR11=(I/*0=$85233,1=$85234//$85204,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[112]"/0,0,0/222,78,60//"UserGuide/section_2.html","S2D3");
	DEF VAR12=(I/*0=$85233,1=$85234//$85205,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[113]"/0,0,0/312,78,60//"UserGuide/section_2.html","S2D3");
	DEF VAR13=(I/*0=$85233,1=$85234//$85206,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[114]"/0,0,0/402,78,60//"UserGuide/section_2.html","S2D3");	

	;循环次数
	DEF VAR15=(I///$85203,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[121]"/0,0,0/132,104,60//"UserGuide/section_2.html","S2D4");粗磨次数
	DEF VAR16=(I///$85204,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[122]"/0,0,0/222,104,60//"UserGuide/section_2.html","S2D4");半粗磨次数
	DEF VAR17=(I///$85205,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[123]"/0,0,0/312,104,60//"UserGuide/section_2.html","S2D4");半精磨次数
	DEF VAR18=(I///$85206,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[124]"/0,0,0/402,104,60//"UserGuide/section_2.html","S2D4");精磨次数
		
	;磨削速度
	DEF VAR27=(R///$85203,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[141]"/0,0,0/132,154,60/);粗磨速度
	DEF VAR28=(R///$85204,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[142]"/0,0,0/222,154,60/);半粗磨速度
	DEF VAR29=(R///$85205,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[143]"/0,0,0/312,154,60/);半精磨速度
	DEF VAR30=(R///$85206,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[144]"/0,0,0/402,154,60/);精磨速度
	
	;砂轮线速度设定
	DEF VAR37=(R/0,//$85203,,,/WR4//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[161]"/0,0,0/132,203,60//"UserGuide/section_2.html","S2D7");粗磨砂轮线速度
	DEF VAR38=(R/0,//$85204,,,/WR4//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[162]"/0,0,0/222,203,60//"UserGuide/section_2.html","S2D7");半粗磨砂轮线速度
	DEF VAR39=(R/0,//$85205,,,/WR4//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[163]"/0,0,0/312,203,60//"UserGuide/section_2.html","S2D7");半精磨砂轮线速度
	DEF VAR40=(R/0,//$85206,,,/WR4//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[164]"/0,0,0/402,203,60//"UserGuide/section_2.html","S2D7");精磨砂轮线速度
	
	;头架转速显示
	DEF VAR23=(R///$85203,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[61]"/0,0,0/132,245,60//"UserGuide/section_2.html","S2D8");粗磨头架转速
	DEF VAR24=(R///$85204,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[62]"/0,0,0/222,245,60//"UserGuide/section_2.html","S2D8");半粗磨头架转速
	DEF VAR25=(R///$85205,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[63]"/0,0,0/312,245,60//"UserGuide/section_2.html","S2D8");半精磨头架转速
	DEF VAR26=(R///$85206,,,/WR2//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[64]"/0,0,0/402,245,60//"UserGuide/section_2.html","S2D8");精磨头架转速
	DEF VAR31=(R///,,,/WR4//"/NC/_N_NC_GD2_ACX/INI[5]"/0,0,0/0,0,0/);螺距调用
	DEF TouShou=(R///,,,/WR4//"/NC/_N_NC_GD2_ACX/WORK[1]"/0,0,0/0,0,0/);工件头数调用
	
	;砂轮转速显示
	DEF VAR32=(R///,,,/WR4//"/NC/_N_NC_GD2_ACX/DRESSER[25]"/0,0,0/0,0,0/);当前砂轮直径调用
	DEF VAR33=(I/0,//$85203,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[71]"/0,0,0/132,266,60//"UserGuide/section_2.html","S2D10");粗磨砂轮转速
	DEF VAR34=(I/0,//$85204,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[72]"/0,0,0/222,266,60//"UserGuide/section_2.html","S2D10");半粗磨砂轮转速
	DEF VAR35=(I/0,//$85205,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[73]"/0,0,0/312,266,60//"UserGuide/section_2.html","S2D10");半精磨砂轮转速
	DEF VAR36=(I/0,//$85206,,,/WR1//"/NC/_N_NC_GD2_ACX/TECHNOLOGY[74]"/0,0,0/402,266,60//"UserGuide/section_2.html","S2D10");精磨砂轮转速

	;界面工艺/DIY选择
	DEF VAR0=(I/*0=$85217,1=$85216//$85218,,,/WR4//"/NC/_N_NC_GD2_ACX/PROCESS[1]"/0,0,0/410,20,65);DIY
	DEF VAR45=(I/*0=$85224,1=$85225//$85226,,,/WR4//"/NC/_N_NC_GD2_ACX/PROCESS[16]"/0,0,0/410,1,65);精简工艺参数/扩展工艺参数
	;界面设定磨削总量计算
	DEF GRID_TOTAL_ACC=(R///$85222,$85222,$85043,/WR1//"/NC/_N_NC_GD2_ACX/PROCESS[15]"/30,1,190/120,1,60/);累计磨削总量显示
	DEF VAR14=(R///$85220,$85219,$85043,/WR1//"/NC/_N_NC_GD2_ACX/PROCESS[13]"/30,20,190/130,20,50/);工艺磨削总量显示 ;ifIsRoughToAmount
;
	DEF DIY_MSG=(R///,$85223,,/WR4//""/30,20,300/0,0,0);DIY_MSG
	;磨削几件后修整
	DEF WORK_CUMU=(I///$85227,$85227,,$85228/WR2//"/NC/_N_NC_GD2_ACX/INI[74]"/230,1,110/300,1,110//"UserGuide/section_2.html","S2D1");磨削工件计数(磨削完毕后累加)

	DEF QCHECK=(I////WR4//"/Plc/Q113.5"/0,0,0/0,0,0);循环启动Q点检测
	DEF TECH_CHECK=(I///$85220,$85219,$85043,/WR4//"/NC/_N_NC_GD2_ACX/PROCESS[3]"/0,0,0/0,0,0);当前执行那道工艺检测
	
	DEF TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/GRIND[1]"/0,0,0/0,0,0/);磨削类型
	DEF WHEEL_RUN_MODE=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[145]"/0,0,0/0,0,0/);砂轮是否恒转速(0否1是)

	HS1=($85001,ac7,se1);"磨削参数"
	HS2=($85002,ac7,se3);"工艺参数"

;

	;

	HS8=($85005,ac7,se1);"返回"

	VS1=($85231,ac7,se3);批量

	PRESS(HS1)
		IF TYPE.VAL<>1
			LM("MASK1","grind.com")
		ELSE
			LM("MASK18","grind.com")
		ENDIF
	END_PRESS

	PRESS(HS2)
		LM("MASK2","process.com")
	END_PRESS

	PRESS(HS3)
		LM("MASK3","dress.com")
	END_PRESS

	PRESS(HS4)
		LM("MASK21","auto.com")
	END_PRESS

	PRESS(HS5)
		LM("MASK31","centerwaiyuan.com")
	END_PRESS
	
	PRESS(HS6)
		LM("MASK32","centerduanmian.com")
	END_PRESS
	
	PRESS(HS7)
		LM("MASK23","centermain.com")
	END_PRESS

	PRESS(VS1)
		LM("MASK2","process.com")
	END_PRESS

	PRESS(VS2)
		LM("MASK29","process.com")
	END_PRESS

	PRESS(HS8)
		EXIT
	END_PRESS

	CHANGE(VAR15);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR16);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR17);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR18);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR19);界面设定磨削总量计算 ;ifIsRoughToAmount
;
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR20);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR21);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR22);界面设定磨削总量计算
		CALL("UP3")
	END_CHANGE

	CHANGE(VAR23);粗磨头架转速计算
		CALL("UP2")
	END_CHANGE

	CHANGE(VAR24);半精磨头架转速计算
		CALL("UP2")
	END_CHANGE

	CHANGE(VAR25);精磨头架转速计算
		CALL("UP2")
	END_CHANGE

	CHANGE(VAR26);终磨头架转速计算
		CALL("UP2")
	END_CHANGE

	CHANGE(VAR45)
		IF VAR45.VAL<>0
			LM("MASK20","process.com")
		ENDIF
	END_CHANGE

	CHANGE(VAR32)
		CALL("ROTATE_SPEED")
		CALL("LINE_SPEED")
	END_CHANGE

	CHANGE(VAR37);砂轮转速计算
		CALL("ROTATE_SPEED")
	END_CHANGE

	CHANGE(VAR38)
		CALL("ROTATE_SPEED")
	END_CHANGE

	CHANGE(VAR39)
		CALL("ROTATE_SPEED")
	END_CHANGE

	CHANGE(VAR40)
		CALL("ROTATE_SPEED")
	END_CHANGE

	CHANGE(VAR33)
		CALL("LINE_SPEED")
	END_CHANGE

	CHANGE(VAR34)
		CALL("LINE_SPEED")
	END_CHANGE

	CHANGE(VAR35)
		CALL("LINE_SPEED")
	END_CHANGE

	CHANGE(VAR36)
		CALL("LINE_SPEED")
	END_CHANGE

	CHANGE(WHEEL_RUN_MODE)
		CALL("ROTATE_LINE_SPEED")
	END_CHANGE

	CHANGE(VAR0);选择DIY工艺时,工艺表格全部不能选中
		CALL("Q_DIY_SET")
	END_CHANGE
	
	CHANGE(QCHECK)
		CALL("Q_DIY_SET")
	END_CHANGE
	
	CHANGE(TECH_CHECK)
		CALL("Q_DIY_SET")
	END_CHANGE

	CHANGE(WAIJING)
		CALL("ZHONGCACU")
	END_CHANGE

	CHANGE(SANXIAN)
		CALL("ZHONGCACU")
	END_CHANGE

	CHANGE(GANGQIU)
		CALL("ZHONGCACU")
	END_CHANGE

	CHANGE(SANXIAN_DISPLAY)
		IF SANXIAN_DISPLAY.VAL==1
			WAIJING.WR=2
			SANXIAN.WR=2
			GANGQIU.WR=2
			ZHONGCICUN.WR=1
		ELSE
			WAIJING.WR=4
			SANXIAN.WR=4
			GANGQIU.WR=4
			ZHONGCICUN.WR=4
		ENDIF
	END_CHANGE

	SUB(ZHONGCACU)
		ZHONGCICUN.VAL=(WAIJING.VAL-SANXIAN.VAL)/2+GANGQIU.VAL
	END_SUB

	SUB(UP3)
		VAR14.VAL=VAR15.VAL*VAR19.VAL+VAR16.VAL*VAR20.VAL+VAR17.VAL*VAR21.VAL+VAR18.VAL*VAR22.VAL ;ifIsRoughToAmount
;
	END_SUB
	
	SUB(DIY_ON)
		;单双磨禁止选择
		VAR10.WR=1
		VAR11.WR=1
		VAR12.WR=1
		VAR13.WR=1
		;循环次数
		VAR15.WR=1
		VAR16.WR=1
		VAR17.WR=1
		VAR18.WR=1
		;进给深度
		VAR19.WR=1 ;ifIsRoughToAmount
;
		VAR20.WR=1
		VAR21.WR=1
		VAR22.WR=1
		;磨削速度
		VAR23.WR=1
		VAR24.WR=1
		VAR25.WR=1
		VAR26.WR=1
		;磨削几次修整设定
		VAR41.WR=1
		VAR42.WR=1
		VAR43.WR=1
		VAR44.WR=1
		;砂轮线速度设定
	END_SUB	

	SUB(DIY_OFF)
		;单双磨
		VAR10.WR=2
		VAR11.WR=2
		VAR12.WR=2
		VAR13.WR=2
		;循环次数
		VAR15.WR=2
		VAR16.WR=2
		VAR17.WR=2
		VAR18.WR=2
		;进给深度
		VAR19.WR=2 ;ifIsRoughToAmount
;
		VAR20.WR=2
		VAR21.WR=2
		VAR22.WR=2
		;磨削速度
		VAR23.WR=2
		VAR24.WR=2
		VAR25.WR=2
		VAR26.WR=2
		;磨削几次修整设定
		VAR41.WR=2
		VAR42.WR=2
		VAR43.WR=2
		VAR44.WR=2
		;砂轮线速度设定
	END_SUB

	SUB(Q_DIY_SET)
		IF VAR0.VAL==1
			VAR14.WR=4
			DIY_MSG.WR=1
			CALL("DIY_ON")
		ELSE
			VAR14.WR=1
			DIY_MSG.WR=4
			CALL("DIY_OFF")
			IF QCHECK.VAL==1
				IF TECH_CHECK.VAL==0
					VAR10.WR=1
					VAR19.WR=1 ;ifIsRoughToAmount
				ELSE
					VAR10.WR=2
					VAR19.WR=2 ;ifIsRoughToAmount
				ENDIF
				IF TECH_CHECK.VAL==1
					VAR11.WR=1
					VAR20.WR=1
				ELSE
					VAR11.WR=2
					VAR20.WR=2
				ENDIF
				IF TECH_CHECK.VAL==2
					VAR12.WR=1
					VAR21.WR=1
				ELSE
					VAR12.WR=2
					VAR21.WR=2
				ENDIF
				IF TECH_CHECK.VAL==3
					VAR13.WR=1
					VAR22.WR=1
				ELSE
					VAR13.WR=2
					VAR22.WR=2
				ENDIF
			ELSE
				VAR10.WR=2
				VAR11.WR=2
				VAR12.WR=2
				VAR13.WR=2
				VAR19.WR=2 ;ifIsRoughToAmount
				VAR20.WR=2
				VAR21.WR=2
				VAR22.WR=2
			ENDIF
		ENDIF	
	END_SUB

	SUB(ROTATE_LINE_SPEED)
		IF WHEEL_RUN_MODE.VAL==0;线速度->转速
			VAR33.WR=1
			VAR34.WR=1
			VAR35.WR=1
			VAR36.WR=1
		ELSE
			VAR33.WR=2
			VAR34.WR=2
			VAR35.WR=2
			VAR36.WR=2
		ENDIF
	END_SUB

	SUB(ROTATE_SPEED)
		IF WHEEL_RUN_MODE.VAL==0;线速度->转速
			VAR33.VAL=VAR37.VAL*60000/(PI*VAR32.VAL)
			VAR34.VAL=VAR38.VAL*60000/(PI*VAR32.VAL)
			VAR35.VAL=VAR39.VAL*60000/(PI*VAR32.VAL)
			VAR36.VAL=VAR40.VAL*60000/(PI*VAR32.VAL)
		ENDIF
	END_SUB

	SUB(LINE_SPEED)
		IF WHEEL_RUN_MODE.VAL==1;转速->线速度
			VAR37.VAL=VAR33.VAL*PI*VAR32.VAL/60000
			VAR38.VAL=VAR34.VAL*PI*VAR32.VAL/60000
			VAR39.VAL=VAR35.VAL*PI*VAR32.VAL/60000
			VAR40.VAL=VAR36.VAL*PI*VAR32.VAL/60000
		ENDIF
	END_SUB

//END
