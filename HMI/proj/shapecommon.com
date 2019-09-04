;

;**********************MASK9:双圆弧:panel_9:;**********************
//M(Mask9/$85400/"panel_9_15_chs.png"/)

	DEF VAR5=(R/0,50//$85434,$85434,,/WR2/"panel_9_21_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[113]"/0,0,0/170,103,60/);初始左滚道
	DEF VAR6=(R/0,50//$85435,$85435,,/WR2/"panel_9_22_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[114]"/0,0,0/170,128,60/);初始右滚道

	DEF VAR7=(R/-10,10//$85436,$85436,,/WR2/"panel_9_21_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[117]"/0,0,0/260,103,60/);调整左滚道
	DEF VAR8=(R/-10,10//$85437,$85437,,/WR2/"panel_9_22_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[118]"/0,0,0/260,128,60/);调整右滚道

	DEF VAR9=(R///$85438,$85438,,/WR1//"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[81]"/0,0,0/350,103,60/);当前左滚道
	DEF VAR10=(R///$85439,$85439,,/WR1//"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[82]"/0,0,0/350,128,60/);当前右滚道

	DEF VAR11=(R/0,10//$85441,$85441,,/WR2/"panel_9_21_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[115]"/0,0,0/170,178,60/);原始左滚道水平偏心
	DEF VAR12=(R/0,10//$85442,$85442,,/WR2/"panel_9_22_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[116]"/0,0,0/170,203,60/);原始右滚道水平偏心

	DEF VAR15=(R/-10,10//$85449,$85449,,/WR2/"panel_9_21_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[119]"/0,0,0/260,178,60/);左滚道水平偏心调整
	DEF VAR16=(R/-10,10//$85450,$85450,,/WR2/"panel_9_22_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[120]"/0,0,0/260,203,60/);右滚道水平偏心调整
	
	DEF VAR31=(R///$85453,$85453,,/WR1//"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[83]"/0,0,0/350,178,60/);当前左滚道水平偏心
	DEF VAR32=(R///$85454,$85454,,/WR1//"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[84]"/0,0,0/350,203,60/);当前右滚道水平偏心

	DEF VAR40=(R/20,90//$85495,$85495,,$85042/WR2/"panel_9_16_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[89]"/70,10,125/180,10,110/);圆弧部分角度
	DEF VAR41=(R/0,90//$85408,$85408,,$85042/WR2/"panel_9_17_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[85]"/70,30,125/180,30,110/);过度1斜线角度
	DEF VAR42=(R/0,20//$85409,$85409,,$85043/WR2/"panel_9_18_chs.png"/"/NC/_N_NC_GD2_ACX/SHAPE_MODEL[88]"/70,50,125/180,50,110/);过度2斜线长度

	DEF VAR43=(I/*0=$85014,1=$85013//$85458,$85458,,/WR2//"/NC/_N_NC_GD2_ACX/DRESSER[40]"/290,10,125/400,10,30/);自动计算
	DEF VAR44=(R/0,50//$85432,$85432,,$85043/WR4/"panel_9_19_chs.png"/"/NC/_N_NC_GD2_ACX/DARC[4]"/290,30,125/400,30,110/);钢球直径
	DEF VAR45=(R/0,90//$85433,$85433,,$85042/WR4/"panel_9_20_chs.png"/"/NC/_N_NC_GD2_ACX/DARC[5]"/290,50,125/400,50,110/);接触角

	DEF TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/GRIND[1]"/0,0,0/0,0,0/);磨削类型
	DEF TECH=(I////WR4//"/NC/_N_NC_GD2_ACX/PROCESS[16]"/0,0,0/0,0,0);精简工艺参数/扩展工艺参数
	DEF PIECE_VOLUME=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[27]"/0,0,0/0,0,0/);单件/批量磨削方式选择
	DEF WARE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[1]"/0,0,0/0,0,0/);修整器
	DEF N_CX_X_TYPE=(I////WR4//"/NC/_N_NC_GD2_ACX/DRESSER[38]"/0,0,0/0,0,0/);成型X修整时修整器前后

	HS1=($85001,ac7,se1);磨削参数
	HS2=($85002,ac7,se1);工艺参数
	HS3=($85003,ac7,se3);修整参数
;

	;

	HS8=($85005,ac7,se1);返回

;
;
	VS3=($85385,ac7,se3);"双圆弧" ifIsArc
	VS4=($85380,ac7,se1);"单滚轮" ifIsSingleAndRound
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
		LM("MASK7","shapecommon.com")
	END_PRESS

	PRESS(VS2)
		LM("MASK8","shapecommon.com")
	END_PRESS

	PRESS(VS3)
		LM("MASK9","shapecommon.com")
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

	CHANGE(VAR5)
		call("UP1")
	END_CHANGE

	CHANGE(VAR6)
		call("UP1")
	END_CHANGE

	CHANGE(VAR7)
		call("UP1")
	END_CHANGE

	CHANGE(VAR8)
		call("UP1")
	END_CHANGE

	CHANGE(VAR11)
		call("UP1")
	END_CHANGE

	CHANGE(VAR12)
		call("UP1")
	END_CHANGE

	CHANGE(VAR15)
		call("UP1")
	END_CHANGE

	CHANGE(VAR16)
		call("UP1")
	END_CHANGE

	CHANGE(VAR43)
		call("UP2")
	END_CHANGE

	CHANGE(VAR44)
		call("UP2")
	END_CHANGE

	CHANGE(VAR45)
		call("UP2")
	END_CHANGE

	SUB(UP1)
		VAR31.VAL=VAR11.VAL+VAR15.VAL
		VAR32.VAL=VAR12.VAL+VAR16.VAL
		VAR9.VAL=VAR5.VAL+VAR7.VAL
		VAR10.VAL=VAR6.VAL+VAR8.VAL
	END_SUB

	SUB(UP2)
		IF VAR43.VAL==0
			VAR44.WR=4
			VAR45.WR=4
			VAR5.WR=2
			VAR6.WR=2
			VAR11.WR=2
			VAR12.WR=2
		ELSE
			VAR44.WR=2
			VAR45.WR=2
			IF (VAR44.VAL<>0) AND (VAR45.VAL<>0)
				VAR5.WR=1
				VAR6.WR=1
				VAR11.WR=1
				VAR12.WR=1
				VAR5.VAL=1.11*VAR44.VAL/2
				VAR6.VAL=1.11*VAR44.VAL/2
				VAR11.VAL=(VAR5.VAL-VAR44.VAL/2)*SIN(VAR45.VAL/180*PI)
				VAR12.VAL=(VAR5.VAL-VAR44.VAL/2)*SIN(VAR45.VAL/180*PI)
			ELSE
				VAR5.WR=2
				VAR6.WR=2
				VAR11.WR=2
				VAR12.WR=2
			ENDIF
		ENDIF
	END_SUB

//END

;