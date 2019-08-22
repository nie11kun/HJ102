;

;

;ifIsVBegin
;**********************MASK11:修整参数_滚压轮V:panel_11:;**********************
//M(Mask11/$85379/"panel_11_1_chs.png"/)

	DEF V_IM=(R///$85114,$85114,,/WR1//"$AA_IM[V]"/10,10,20/30,10,60/3);V_IM
;

	DEF VAR11=(R/0,80//$85604,$85604,,$85047/WR2/"panel_11_1_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[19]"/330,70,110/440,70,110//"UserGuide/section_4.html","S4D10");滚压轮停留时间
	
	DEF VAR2=(R/0,50//$85602,$85602,,$85043/WR2/"panel_11_3_chs.png"/"/NC/_N_NC_GD2_ACX/DRESSER[2]"/330,110,110/440,110,110//"UserGuide/section_4.html","S4D11");齿高

	DEF VAR1=(R/-500,500//$85603,$85603,,$85043/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[13]"/330,140,110/440,140,110/);NC用初始接触
	DEF VAR3=(R/-500,500//$85622,$85622,,$85043/WR2/"panel_11_7_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[15]"/330,160,110/440,160,110//"UserGuide/section_4.html","S4D2");初始接触位置

	DEF VAR5=(R/-500,500//$85623,$85623,,$85043/WR2/"panel_11_4_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[11]"/330,190,110/440,190,110//"UserGuide/section_4.html","S4D3");当前接触位置

	DEF VAR7=(R/0,500//$85620,$85620,,$85043/WR2/"panel_11_5_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[1]"/330,240,110/440,240,110//"UserGuide/section_4.html","S4D4");修整轮直径
	DEF VAR8=(R/0,60//$85621,$85621,,$85046/WR2/"panel_11_6_chs.png"/"/NC/_N_NC_GD2_ACX/WHEEL[2]"/330,260,110/440,260,110//"UserGuide/section_4.html","S4D5");修整轮线速度
	DEF VAR9=(I///$85600,$85600,,$85044/WR1//"/NC/_N_NC_GD2_ACX/WHEEL[20]"/330,280,110/440,280,110/);修整轮转速

	;+++++++++++++++++++++++++++++++
;

	DEF VAR10=(R///,,,/WR4//"/NC/_N_NC_GD2_ACX/DRESSER[24]"/0,0,0/0,0,0/);新砂轮直径

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
;
;
;
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

	CHANGE(VAR3)
		CALL("UP1")
	END_CHANGE

	CHANGE(VAR2)
		CALL("UP1")
	END_CHANGE

	CHANGE(VAR7)
		CALL("UP1")
		VAR9.VAL=VAR8.VAL*60000/(PI*VAR7.VAL);修整轮转速计算
	END_CHANGE

	CHANGE(VAR8);修整轮转速计算
		VAR9.VAL=VAR8.VAL*60000/(PI*VAR7.VAL)
	END_CHANGE
	
	CHANGE(para_switch)
		CALL("UP2")
	END_CHANGE

	CHANGE(QCHECK)
		IF QCHECK.VAL==1
			VAR3.WR=1
			VAR2.WR=1
			VAR5.WR=1
			VAR7.WR=1
			para_switch.WR=1
		ELSE
			VAR3.WR=2
			VAR2.WR=2
			VAR5.WR=2
			VAR7.WR=2
			para_switch.WR=2
			CALL("UP2")
		ENDIF
	END_CHANGE

	SUB(UP1)
		VAR1.VAL=VAR3.VAL-VAR2.VAL;NC用初始接触位
	END_SUB

//END
;ifIsVEnd

;

;

;

;

;

;

