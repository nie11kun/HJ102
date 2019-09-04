;

;

;

;ifIsXZSRBegin
;**********************MASK12:修整参数_XZ单滚轮:panel_12:;**********************
//M(Mask12/$85380/"panel_12_1_chs.png"/)

	DEF X_IM=(R///$85118,$85118,,/WR1//"$AA_IM[X]"/10,10,20/30,10,60/3);X_IM
	DEF Z_IM=(R///$85119,$85119,,/WR1//"$AA_IM[Z]"/10,30,20/30,30,60/3);Z_IM

	DEF VAR12=(R/-800,800//$85601,$85601,,$85043/WR2/"panel_12_7_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[3]"/330,20,110/440,20,110//"UserGuide/section_4.html","S4D12");回零时砂轮与修整轮中间距
	DEF para_switch2=(I/*0=$85058,1=$85059//$85063,$85063,,/WR2/"panel_12_7_chs.png"/"/NC/_N_NC_GD2_ACX/PARA_LOCK_SWITCH[11]"/0,0,0/530,20,18/);参数锁定开关

	DEF VAR11=(R/-2000,2000//$85607,$85626,,$85043/WR2/"panel_12_1_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[22]"/330,40,110/440,40,110//"UserGuide/section_4.html","S4D13");砂轮修整轮中心
	DEF para_switch=(I/*0=$85058,1=$85059//$85063,$85063,,/WR2/"panel_12_1_chs.png"/"/NC/_N_NC_GD2_ACX/PARA_LOCK_SWITCH[4]"/0,0,0/530,40,18/);参数锁定开关

	DEF VAR0=(R/0,300//$85614,$85614,,$85043/WR4//""/330,60,110/440,60,110/);滚轮间距

	DEF VAR1=(R/0,10//$85612,$85612,,$85043/WR2/"panel_12_2_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[5]"/330,90,110/440,90,110//"UserGuide/section_4.html","S4D1");圆弧半径
	DEF VAR2=(R/0,10//$85611,$85611,,$85043/WR4//"/NC/_N_NC_GD2_ACX/WHEEL[6]"/330,110,110/440,110,110/);右圆弧半径

	DEF VAR3=(R///$85627,$85627,,$85043/WR1/"panel_12_3_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[13]"/330,140,110/440,140,110//"UserGuide/section_4.html","S4D14");初始接触位置
	DEF VAR4=(R///$85630,$85630,,$85043/WR4//"/NC/_N_NC_GD2_ACX/WHEEL[14]"/330,160,110/440,160,110/);初始右端接触位置

	DEF VAR5=(R///$85628,$85628,,$85043/WR2/"panel_12_4_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[11]"/330,190,110/440,190,110//"UserGuide/section_4.html","S4D15");当前接触位置
	DEF VAR6=(R///$85632,$85632,,$85043/WR4//"/NC/_N_NC_GD2_ACX/WHEEL[12]"/330,210,110/440,210,110/);当前右端接触位置

	DEF VAR7=(R/0,500//$85620,$85620,,$85043/WR2/"panel_12_5_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[1]"/330,240,110/440,240,110//"UserGuide/section_4.html","S4D4");修整轮直径
	DEF VAR8=(R/0,60//$85621,$85621,,$85046/WR2/"panel_12_6_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[2]"/330,260,110/440,260,110//"UserGuide/section_4.html","S4D5");修整轮线速度
	
	DEF DWHEEL_RPM=(I/0,//$85600,$85600,,$85044/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[20]"/330,280,110/440,280,110/);修整轮转速

	DEF VAR10=(R////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[24]"/0,0,0/0,0,0/);新砂轮直径

	DEF QCHECK=(I////WR4//"/Plc/Q113.5"/0,0,0/0,0,0);循环启动Q点检测

	DEF TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/GRIND[1]"/0,0,0/0,0,0/);磨削类型
	DEF TECH=(I////WR4//"/NC/_N_NC_GD2_ACX/PROCESS[16]"/0,0,0/0,0,0);精简工艺参数/扩展工艺参数
	DEF PIECE_VOLUME=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[27]"/0,0,0/0,0,0/);单件/批量磨削方式选择
	DEF WARE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[1]"/0,0,0/0,0,0/);修整器
	DEF N_CX_X_TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[38]"/0,0,0/0,0,0/);成型X修整时修整器前后
	DEF cixindiaoyong=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[115]"/0,0,0/0,0,0/);调用默认齿形程序0/通用齿形程序1

	HS1=($85001,ac7,se1);磨削参数
	HS2=($85002,ac7,se1);工艺参数
	HS3=($85003,ac7,se3);修整参数
;

	;

	HS8=($85005,ac7,se1);返回

;
;
	VS3=($85385,ac7,se1);"双圆弧" ifIsArc
	VS4=($85380,ac7,se3);"单滚轮" ifIsSingleAndRound
	VS6=($85382,ac7,se1);"方滚轮" ifIsSingleAndRound
;
	VS7=($85379,ac7,se2);"滚压轮"
;

	PRESS(HS1)
		IF TYPE.VAL<>1
			LM("MASK1","grind.com")
		ELSE
			LM("MASK18","grind.com")
		ENDIF
	END_PRESS

	PRESS(HS2)
		IF TECH.VAL==0;基本工艺
			IF PIECE_VOLUME.VAL==0;单件
				LM("MASK29","process.com")
			ELSE
				LM("MASK2","process.com")
			ENDIF
		ELSE
			IF PIECE_VOLUME.VAL==0;单件
				LM("MASK30","process.com")
			ELSE
				LM("MASK20","process.com")
			ENDIF
		ENDIF
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

	PRESS(HS8)
		EXIT
	END_PRESS

	PRESS(VS1)
		IF cixindiaoyong.VAL==0
			LM("MASK7","shape.com")
		ELSE
			LM("MASK7","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS2)
		IF cixindiaoyong.VAL==0
			LM("MASK8","shape.com")
		ELSE
			LM("MASK8","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS3)
		IF cixindiaoyong.VAL==0
			LM("MASK9","shape.com")
		ELSE
			LM("MASK9","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS4)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK4","dressware.com")
		ELSE;XZ/X
			LM("MASK12","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS5)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK5","dressware.com")
		ELSE;XZ/X
			LM("MASK13","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS6)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK6","dressware.com")
		ELSE;XZ/X
			LM("MASK14","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS7)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK11","dressware.com")
		ELSE;XZ/X
			IF TYPE.VAL==0;WAI
				LM("MASK16","dressware.com")
			ELSE;NEI
				IF N_CX_X_TYPE.VAL==0;NEI-QIAN
					LM("MASK17","dressware.com")
				ELSE
					LM("MASK19","dressware.com")
				ENDIF
			ENDIF
		ENDIF
	END_PRESS

	PRESS(VS8)
		LM("MASK15","dressware.com")
	END_PRESS

	CHANGE(VAR1)
		VAR2.VAL=VAR1.VAL
	END_CHANGE

	CHANGE(VAR3)
		VAR4.VAL=VAR3.VAL
	END_CHANGE

	CHANGE(VAR5)
		VAR6.VAL=VAR5.VAL
	END_CHANGE

	CHANGE(VAR12)
		call("UP3")
	END_CHANGE

	CHANGE(VAR7);修整轮转速计算
		DWHEEL_RPM.VAL=60000*VAR8.VAL/(PI*VAR7.VAL)
		call("UP3")
	END_CHANGE
	
	CHANGE(VAR8);修整轮转速计算
		DWHEEL_RPM.VAL=60000*VAR8.VAL/(PI*VAR7.VAL)
	END_CHANGE
	
	CHANGE(para_switch)
		call("UP1")
	END_CHANGE

	CHANGE(para_switch2)
		call("UP2")
	END_CHANGE

	CHANGE(QCHECK)
		IF QCHECK.VAL==1
			VAR1.WR=1
			VAR3.WR=1
			VAR5.WR=1
			VAR7.WR=1
			VAR11.WR=1
			VAR12.WR=1
			para_switch.WR=1
			para_switch2.WR=1
		ELSE
			VAR1.WR=2
			VAR3.WR=1
			VAR5.WR=2
			VAR7.WR=2
			para_switch.WR=2
			para_switch2.WR=2
			CALL("UP1")
			CALL("UP2")
		ENDIF
	END_CHANGE

	SUB(UP1)
		IF para_switch.VAL==0
			VAR11.WR=2
		ELSE
			VAR11.WR=1
		ENDIF
	END_SUB

	SUB(UP2)
		IF para_switch2.VAL==0
			VAR12.WR=2
		ELSE
			VAR12.WR=1
		ENDIF
	END_SUB

	SUB(UP3)
		IF TYPE.VAL<>1;不是内螺纹
			VAR3.VAL=-(VAR12.VAL-VAR7.VAL/2-VAR10.VAL/2);初始接触
		ELSE
			VAR3.VAL=-(VAR12.VAL+VAR7.VAL/2+VAR10.VAL/2);初始接触位
		ENDIF
		VAR4.VAL=VAR3.VAL
	END_SUB

//END

;**********************MASK14:修整参数_XZ方滚轮:panel_14:;**********************
//M(Mask14/$85382/"panel_14_1_chs.png"/)

	DEF X_IM=(R///$85118,$85118,,/WR1//"$AA_IM[X]"/10,10,20/30,10,60/3);X_IM
	DEF Z_IM=(R///$85119,$85119,,/WR1//"$AA_IM[Z]"/10,30,20/30,30,60/3);Z_IM

	DEF VAR12=(R/-800,800//$85601,$85601,,$85043/WR2/"panel_14_1_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[3]"/330,20,110/440,20,110//"UserGuide/section_4.html","S4D12");回零时砂轮与修整轮中间距
	DEF para_switch2=(I/*0=$85058,1=$85059//$85063,$85063,,/WR2/"panel_14_1_chs.png"/"/NC/_N_NC_GD2_ACX/PARA_LOCK_SWITCH[11]"/0,0,0/530,20,18/);参数锁定开关

	DEF VAR11=(R/-2000,2000//$85626,$85626,,$85043/WR2/"panel_14_2_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[22]"/330,40,110/440,40,110//"UserGuide/section_4.html","S4D13");砂轮修整轮中心
	DEF para_switch=(I/*0=$85058,1=$85059//$85063,$85063,,/WR2/"panel_14_2_chs.png"/"/NC/_N_NC_GD2_ACX/PARA_LOCK_SWITCH[4]"/0,0,0/530,40,18/);参数锁定开关

	DEF VAR0=(R/0,100//$85615,$85615,,$85043/WR2/"panel_14_3_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[4]"/330,60,110/440,60,110//"UserGuide/section_4.html","S4D7");方滚轮厚度

	DEF VAR1=(R/0,10//$85610,$85610,,$85043/WR2/"panel_14_4_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[9]"/330,90,110/440,90,110//"UserGuide/section_4.html","S4D1");左圆弧半径
	DEF VAR2=(R/0,10//$85611,$85611,,$85043/WR2/"panel_14_5_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[10]"/330,110,110/440,110,110//"UserGuide/section_4.html","S4D1");右圆弧半径

	DEF VAR3=(R///$85627,$85627,,$85043/WR1/"panel_14_6_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[13]"/330,140,110/440,140,110//"UserGuide/section_4.html","S4D14");初始接触位置
	DEF VAR4=(R///$85630,$85630,,$85043/WR4//"/NC/_N_NC_GD2_ACX/WHEEL[14]"/330,160,110/440,160,110//"UserGuide/section_4.html","S4D14");初始右端接触位置

	DEF VAR5=(R///$85628,$85628,,$85043/WR1/"panel_14_7_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[11]"/330,190,110/440,190,110//"UserGuide/section_4.html","S4D15");当前接触位置
	DEF VAR6=(R///$85632,$85632,,$85043/WR4//"/NC/_N_NC_GD2_ACX/WHEEL[12]"/330,210,110/440,210,110//"UserGuide/section_4.html","S4D15");当前右端接触位置

	DEF VAR7=(R/0,500//$85620,$85620,,$85043/WR2/"panel_14_8_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[1]"/330,240,110/440,240,110//"UserGuide/section_4.html","S4D4");修整轮直径
	DEF VAR8=(R/0,60//$85621,$85621,,$85045/WR2/"panel_14_9_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[2]"/330,260,110/440,260,110//"UserGuide/section_4.html","S4D5");修整轮线速度

	DEF VAR9=(I/0,//$85600,$85600,,$85044/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[20]"/330,280,110/440,280,110/);修整轮转速
	DEF VAR10=(R////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[24]"/0,0,0/0,0,0/);新砂轮直径
		
	DEF QCHECK=(I////WR4//"/Plc/Q113.5"/0,0,0/0,0,0);循环启动Q点检测

	DEF TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/GRIND[1]"/0,0,0/0,0,0/);磨削类型
	DEF TECH=(I////WR4//"/NC/_N_NC_GD2_ACX/PROCESS[16]"/0,0,0/0,0,0);精简工艺参数/扩展工艺参数
	DEF PIECE_VOLUME=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[27]"/0,0,0/0,0,0/);单件/批量磨削方式选择
	DEF WARE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[1]"/0,0,0/0,0,0/);修整器
	DEF N_CX_X_TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[38]"/0,0,0/0,0,0/);成型X修整时修整器前后
	DEF cixindiaoyong=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[115]"/0,0,0/0,0,0/);调用默认齿形程序0/通用齿形程序1

	HS1=($85001,ac7,se1);磨削参数
	HS2=($85002,ac7,se1);工艺参数
	HS3=($85003,ac7,se3);修整参数
;

	;

	HS8=($85005,ac7,se1);返回

;
;
	VS3=($85385,ac7,se1);"双圆弧" ifIsArc
	VS4=($85380,ac7,se1);"单滚轮" ifIsSingleAndRound
	VS6=($85382,ac7,se3);"方滚轮" ifIsSingleAndRound
;
	VS7=($85379,ac7,se2);"滚压轮"
;

	PRESS(HS1)
		IF TYPE.VAL<>1
			LM("MASK1","grind.com")
		ELSE
			LM("MASK18","grind.com")
		ENDIF
	END_PRESS

	PRESS(HS2)
		IF TECH.VAL==0;基本工艺
			IF PIECE_VOLUME.VAL==0;单件
				LM("MASK29","process.com")
			ELSE
				LM("MASK2","process.com")
			ENDIF
		ELSE
			IF PIECE_VOLUME.VAL==0;单件
				LM("MASK30","process.com")
			ELSE
				LM("MASK20","process.com")
			ENDIF
		ENDIF
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

	PRESS(HS8)
		EXIT
	END_PRESS

	PRESS(VS1)
		IF cixindiaoyong.VAL==0
			LM("MASK7","shape.com")
		ELSE
			LM("MASK7","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS2)
		IF cixindiaoyong.VAL==0
			LM("MASK8","shape.com")
		ELSE
			LM("MASK8","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS3)
		IF cixindiaoyong.VAL==0
			LM("MASK9","shape.com")
		ELSE
			LM("MASK9","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS4)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK4","dressware.com")
		ELSE;XZ/X
			LM("MASK12","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS5)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK5","dressware.com")
		ELSE;XZ/X
			LM("MASK13","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS6)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK6","dressware.com")
		ELSE;XZ/X
			LM("MASK14","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS7)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK11","dressware.com")
		ELSE;XZ/X
			IF TYPE.VAL==0;WAI
				LM("MASK16","dressware.com")
			ELSE;NEI
				IF N_CX_X_TYPE.VAL==0;NEI-QIAN
					LM("MASK17","dressware.com")
				ELSE
					LM("MASK19","dressware.com")
				ENDIF
			ENDIF
		ENDIF
	END_PRESS

	PRESS(VS8)
		LM("MASK15","dressware.com")
	END_PRESS

	CHANGE(VAR3)
		VAR4.VAL=VAR3.VAL
	END_CHANGE

	CHANGE(VAR5)
		VAR6.VAL=VAR5.VAL
	END_CHANGE
	
	CHANGE(VAR7);修整轮转速计算
		VAR9.VAL=VAR8.VAL*60000/(PI*VAR7.VAL)
		CALL("UP3")
	END_CHANGE
	
	CHANGE(VAR8);修整轮转速计算
		VAR9.VAL=VAR8.VAL*60000/(PI*VAR7.VAL)
	END_CHANGE

	CHANGE(VAR12)
		CALL("UP3")
	END_CHANGE

	CHANGE(para_switch)
		call("UP1")
	END_CHANGE

	CHANGE(para_switch2)
		call("UP2")
	END_CHANGE

	CHANGE(QCHECK)
		IF QCHECK.VAL==1
			VAR0.WR=1
			VAR1.WR=1
			VAR2.WR=1
			VAR3.WR=1
			VAR5.WR=1
			VAR7.WR=1
			VAR11.WR=1
			VAR12.WR=1
			para_switch.WR=1
			para_switch2.WR=1
		ELSE
			VAR0.WR=2
			VAR1.WR=2
			VAR2.WR=2
			VAR3.WR=1
			VAR5.WR=1
			VAR7.WR=2
			para_switch.WR=2
			para_switch2.WR=2
			CALL("UP1")
			CALL("UP2")
		ENDIF
	END_CHANGE	
	
	SUB(UP1)
		IF para_switch.VAL==0
			VAR11.WR=2
		ELSE
			VAR11.WR=1
		ENDIF
	END_SUB

	SUB(UP2)
		IF para_switch2.VAL==0
			VAR12.WR=2
		ELSE
			VAR12.WR=1
		ENDIF
	END_SUB

	SUB(UP3)
		IF TYPE.VAL<>1;不是内螺纹
			VAR3.VAL=-(VAR12.VAL-VAR7.VAL/2-VAR10.VAL/2);初始接触
		ELSE
			VAR3.VAL=-(VAR12.VAL+VAR7.VAL/2+VAR10.VAL/2);初始接触位
		ENDIF
		VAR4.VAL=VAR3.VAL
	END_SUB

//END
;ifIsXZSREnd

;

;

;ifIsXNeiFrontBegin
;**********************MASK17:修整参数_滚压轮X_内_前:panel_17:;**********************
//M(Mask17/$85379/"panel_17_1_chs.png"/)

	DEF X_IM=(R///$85118,$85118,,/WR1//"$AA_IM[X]"/10,10,20/30,10,60/3);X_IM
	DEF Z_IM=(R///$85119,$85119,,/WR1//"$AA_IM[Z]"/10,30,20/30,30,60/3);Z_IM

	DEF VAR0=(R/-800,800//$85601,$85601,,$85043/WR2/"panel_17_2_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[3]"/325,40,110/440,40,110//"UserGuide/section_4.html","S4D12");回零时砂轮与修整轮中间距
	DEF para_switch1=(I/*0=$85058,1=$85059//$85063,$85063,,/WR2/"panel_17_2_chs.png"/"/NC/_N_NC_GD2_ACX/PARA_LOCK_SWITCH[7]"/0,0,0/530,40,18/);参数锁定开关

	DEF VAR12=(R/-2000,2000//$85626,$85626,,$85043/WR2/"panel_17_7_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[22]"/325,70,110/440,70,110//"UserGuide/section_4.html","S4D13");砂轮与修整轮Z中心

	DEF VAR11=(R/0,80//$85604,$85604,,$85047/WR2/"panel_17_1_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[19]"/325,140,110/440,140,110//"UserGuide/section_4.html","S4D10");滚压轮停留时间

	DEF VAR2=(R/0,50//$85602,$85602,,$85043/WR2/"panel_17_3_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[2]"/325,170,110/440,170,110//"UserGuide/section_4.html","S4D11");齿高
	DEF VAR7=(R/0,500//$85620,$85620,,$85043/WR2/"panel_17_5_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[1]"/325,190,110/440,190,110//"UserGuide/section_4.html","S4D4");修整轮直径
	DEF VAR8=(R/0,60//$85621,$85621,,$85046/WR2/"panel_17_6_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[2]"/325,210,110/440,210,110//"UserGuide/section_4.html","S4D5");修整轮线速度
	DEF VAR9=(I/0,//$85600,$85600,,$85044/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[20]"/325,230,110/440,230,110/);修整轮转速

	DEF VAR1=(R///$85633,$85633,,$85043/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[13]"/325,260,130/440,260,110/);NC用初始接触
	DEF VAR3=(R///$85627,$85627,,$85043/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[15]"/325,280,130/440,280,110//"UserGuide/section_4.html","S4D14");初始接触位置
	DEF VAR5=(R///$85628,$85628,,$85043/WR1/"panel_17_4_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[11]"/325,300,130/440,300,110//"UserGuide/section_4.html","S4D15");当前接触位置

	DEF VAR10=(R////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[24]"/0,0,0/0,0,0/);新砂轮直径

	DEF QCHECK=(I////WR4//"/Plc/Q113.5"/0,0,0/0,0,0);循环启动Q点检测

	DEF TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/GRIND[1]"/0,0,0/0,0,0/);磨削类型
	DEF TECH=(I////WR4//"/NC/_N_NC_GD2_ACX/PROCESS[16]"/0,0,0/0,0,0);精简工艺参数/扩展工艺参数
	DEF PIECE_VOLUME=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[27]"/0,0,0/0,0,0/);单件/批量磨削方式选择
	DEF WARE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[1]"/0,0,0/0,0,0/);修整器
	DEF N_CX_X_TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[38]"/0,0,0/0,0,0/);成型X修整时修整器前后
	DEF cixindiaoyong=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[115]"/0,0,0/0,0,0/);调用默认齿形程序0/通用齿形程序1

	HS1=($85001,ac7,se1);磨削参数
	HS2=($85002,ac7,se1);工艺参数
	HS3=($85003,ac7,se3);修整参数
;

	;

	HS8=($85005,ac7,se1);返回

;
;
	VS3=($85385,ac7,se2);"双圆弧" ifIsArc
	VS4=($85380,ac7,se2);"单滚轮" ifIsSingleAndRound
	VS6=($85382,ac7,se2);"方滚轮" ifIsSingleAndRound
;
	VS7=($85379,ac7,se3);"滚压轮"
;

	PRESS(HS1)
		IF TYPE.VAL<>1
			LM("MASK1","grind.com")
		ELSE
			LM("MASK18","grind.com")
		ENDIF
	END_PRESS

	PRESS(HS2)
		IF TECH.VAL==0;基本工艺
			IF PIECE_VOLUME.VAL==0;单件
				LM("MASK29","process.com")
			ELSE
				LM("MASK2","process.com")
			ENDIF
		ELSE
			IF PIECE_VOLUME.VAL==0;单件
				LM("MASK30","process.com")
			ELSE
				LM("MASK20","process.com")
			ENDIF
		ENDIF
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

	PRESS(HS8)
		EXIT
	END_PRESS

	PRESS(VS1)
		IF cixindiaoyong.VAL==0
			LM("MASK7","shape.com")
		ELSE
			LM("MASK7","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS2)
		IF cixindiaoyong.VAL==0
			LM("MASK8","shape.com")
		ELSE
			LM("MASK8","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS3)
		IF cixindiaoyong.VAL==0
			LM("MASK9","shape.com")
		ELSE
			LM("MASK9","shapecommon.com")
		ENDIF
	END_PRESS

	PRESS(VS4)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK4","dressware.com")
		ELSE;XZ/X
			LM("MASK12","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS5)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK5","dressware.com")
		ELSE;XZ/X
			LM("MASK13","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS6)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK6","dressware.com")
		ELSE;XZ/X
			LM("MASK14","dressware.com")
		ENDIF
	END_PRESS

	PRESS(VS7)
		IF (WARE.VAL==0) OR (WARE.VAL==2);VW/V
			LM("MASK11","dressware.com")
		ELSE;XZ/X
			IF TYPE.VAL==0;WAI
				LM("MASK16","dressware.com")
			ELSE;NEI
				IF N_CX_X_TYPE.VAL==0;NEI-QIAN
					LM("MASK17","dressware.com")
				ELSE
					LM("MASK19","dressware.com")
				ENDIF
			ENDIF
		ENDIF
	END_PRESS

	PRESS(VS8)
		LM("MASK15","dressware.com")
	END_PRESS

	CHANGE(VAR0)
		call("UP1")
	END_CHANGE

	CHANGE(VAR2)
		call("UP1")
	END_CHANGE

	CHANGE(VAR3)
		call("UP1")
	END_CHANGE

	CHANGE(VAR7)
		call("UP1")
		VAR9.VAL=VAR8.VAL*60000/(PI*VAR7.VAL);修整轮转速计算
	END_CHANGE

	CHANGE(VAR8)
		VAR9.VAL=VAR8.VAL*60000/(PI*VAR7.VAL);修整轮转速计算
	END_CHANGE

	CHANGE(para_switch1)
		call("UP3")
	END_CHANGE

	CHANGE(QCHECK)
		IF QCHECK.VAL==1
			VAR0.WR=1
			VAR2.WR=1
			VAR7.WR=1
			VAR20.WR=1
			VAR21.WR=1
			para_switch1.WR=1
			para_switch2.WR=1
			para_switch3.WR=1
		ELSE
			VAR2.WR=2
			VAR7.WR=2
			para_switch1.WR=2
			para_switch2.WR=2
			para_switch3.WR=2
			CALL("UP3")
		ENDIF
	END_CHANGE

	SUB(UP1)
		VAR3.VAL=-(VAR0.VAL+VAR7.VAL/2+VAR10.VAL/2);初始接触位
		VAR1.VAL=VAR3.VAL+VAR2.VAL;NC用初始接触
	END_SUB

	SUB(UP3)
		IF para_switch1.VAL==0
			VAR0.WR=2
		ELSE
			VAR0.WR=1
		ENDIF
	END_SUB

//END
;ifIsXNeiFrontEnd

;

;

