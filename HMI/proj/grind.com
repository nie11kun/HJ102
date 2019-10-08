;

;ifIsInternalBegin
;**********************MASK18:磨削参数_内:panel_18:;**********************
//M(Mask18/$85020//)

	DEF VAR1=(I/*0=$85135,1=$85136,2=$85137,3=$85138,4=$85139/1/$85134,,,/WR4//"/NC/_N_NC_GD2_ACX/GRIND[1]"/0,0,0/10,10,60/);磨削类型,生成文件用	
	DEF PIECE_VOLUME=(I//1/$85170,$85170,,/WR4//"/NC/_N_NC_GD2_ACX/INI[27]"/360,10,70/460,10,80//"UserGuide/section_1.html","S1D1");单件/批量磨削方式选择

	DEF X_IM=(R///$85118,$85118,,/WR1//"$AA_IM[X]"/10,10,20/30,10,60/3);X_IM
	DEF Z_IM=(R///$85119,$85119,,/WR1//"$AA_IM[Z]"/10,30,20/30,30,60/3);Z_IM
	DEF X_DRF=(R///$85116,$85116,,/WR1//"$AC_DRF[X]"/120,10,50/170,10,60/7);DRF_X

	DEF Z_SOFTENDP=(R////WR4//"$AA_SOFTENDP[Z]"/0,0,0/0,0,0/);SOFRENDP_Z

	DEF VAR8=(R3/-2000,2000//$85108,$85108,,/WR2/"panel_18_7_chs.png"/"/NC/_N_NC_GD2_ACX/INI[2]"/360,10,202/460,10,60/6/"UserGuide/section_1.html","S1D10");工件左端
	DEF VAR9=(R3/-2000,2000//$85109,$85109,,/WR2/"panel_18_8_chs.png"/"/NC/_N_NC_GD2_ACX/INI[3]"/360,30,202/460,30,60/6/"UserGuide/section_1.html","S1D11");工件右端
	DEF VAR10=(R/-1000,1000//$85165,$85165,,/WR2/"panel_18_9_chs.png"/"/NC/_N_NC_GD2_ACX/INI[11]"/360,60,202/460,60,60/6/"UserGuide/section_1.html","S1D28");工件中心
	DEF Z_INIT=(R/-2000,2000//$85101,$85101,,/WR2/"panel_18_23_chs.png"/"/NC/_N_NC_GD2_ACX/INI[29]"/360,80,202/460,80,60/6/"UserGuide/section_1.html","S1D30");内螺纹时台面起始位置

	DEF JSX_X=(R/-800,800//$85129,$85129,,/WR2/"panel_18_25_chs.png"/"/NC/_N_NC_GD2_ACX/INI[24]"/360,110,202/460,110,60/7/"UserGuide/section_1.html","S1D14");机械手停留x
	DEF JXS_Z=(R/-2000,2000//$85130,$85130,,/WR2/"panel_18_23_chs.png"/"/NC/_N_NC_GD2_ACX/INI[168]"/360,130,202/460,130,60/7/"UserGuide/section_1.html","S1D30");机械手停留z

	DEF MAOSHUAJU=(R/0,800//$85126,$85126,,/WR2//"/NC/_N_NC_GD2_ACX/INI[157]"/360,190,202/460,190,60/);前后毛刷距
	DEF QIANDANGEJU=(R/0,200//$85127,$85127,,/WR2//"/NC/_N_NC_GD2_ACX/INI[158]"/360,210,202/460,210,60/);前单个毛刷距
	DEF HOUDANGEJU=(R/0,200//$85128,$85128,,/WR2//"/NC/_N_NC_GD2_ACX/INI[159]"/360,230,202/460,230,60/);后单个毛刷距

	DEF MAOSHUAZHUXUAN=(I/0,2//$85200,$85200,,/WR2//"/NC/_N_NC_GD2_ACX/INI[13]"/360,270,202/460,270,60/);毛刷组选
	DEF YIJIAGONG=(I/0,//$85189,$85189,,/WR2//"/NC/_N_NC_GD2_ACX/INI[164]"/360,290,202/460,290,60/);当前毛刷已加工多少件
	DEF GENHUANJISHU=(I/0,//$85190,$85190,,/WR2//"/NC/_N_NC_GD2_ACX/INI[165]"/360,310,202/460,310,60/);多少件后换毛刷
	DEF MAOSHUAFUWEI=(I/*0=$85191,1=$85191//$85191,,,/WR2//"/NC/_N_NC_GD2_ACX/INI[166]"/0,0,0/460,330,60/);毛刷重新复位

	DEF VAR45=(I////WR4//"/NC/_N_NC_GD2_ACX/PROCESS[16]"/0,0,0/0,0,0);精简工艺参数/扩展工艺参数

	DEF QCHECK=(I////WR4//"/Plc/Q113.5"/0,0,0/0,0,0);循环启动Q点检测

	DEF JIXIESHOU=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[86]"/0,0,0/0,0,0);机械手
	DEF KONG_YUN_XING=(I////WR4//"/NC/_N_NC_GD2_ACX/INI[167]"/0,0,0/0,0,0/);空运行
	DEF MONI_TEST=(I////WR4//"/NC/_N_NC_GD2_ACX/GRIND[9]"/0,0,0/0,0,0/);模拟测试

	HS1=($85001,ac7,se3);磨削参数
	HS2=($85002,ac7,se1);工艺参数

;

	;

	HS8=($85005,ac7,se1);返回

	VS1=($85035,ac7,se1);
	VS2=($85064,ac7,se1);
	VS3=($85065,ac7,se1);

	LOAD
		IF JIXIESHOU.VAL==1
			VS1.SE=3
		ENDIF
		IF KONG_YUN_XING.VAL==1
			VS2.SE=3
		ENDIF
		IF MONI_TEST.VAL==1
			VS3.SE=3
		ENDIF
	END_LOAD

	PRESS(VS1)
		IF JIXIESHOU.VAL==0
			JIXIESHOU.VAL=1
			VS1.SE=3
		ELSE
			JIXIESHOU.VAL=0
			VS1.SE=1
		ENDIF	
	END_PRESS

	PRESS(VS2)
		IF KONG_YUN_XING.VAL==0
			KONG_YUN_XING.VAL=1
			VS2.SE=3
		ELSE
			KONG_YUN_XING.VAL=0
			VS2.SE=1
		ENDIF	
	END_PRESS

	PRESS(VS3)
		IF MONI_TEST.VAL==0
			MONI_TEST.VAL=1
			VS3.SE=3
		ELSE
			MONI_TEST.VAL=0
			VS3.SE=1
		ENDIF	
	END_PRESS

	PRESS(HS1)
		LM("MASK18","grind.com")
	END_PRESS

	PRESS(HS2)
		IF VAR45.VAL==0;基本工艺
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

	CHANGE(MAOSHUAFUWEI)
		IF MAOSHUAFUWEI.VAL<>0
			MAOSHUAZHUXUAN.VAL=0
			YIJIAGONG.VAL=0
			MAOSHUAFUWEI.VAL=0
		ENDIF
	END_CHANGE

	CHANGE(VAR1)
		IF VAR1.VAL<>1
			LM("MASK1","grind.com")
		ENDIF
	END_CHANGE

	CHANGE(VAR6)
		call("UP3")
	END_CHANGE

	CHANGE(VAR7)
		call("UP3")
	END_CHANGE

	CHANGE(WORK_MID_DIA)
		call("UP3")
	END_CHANGE

	CHANGE(VAR23)
		call("UP2")
		call("UP3")
	END_CHANGE
	
	CHANGE(QCHECK)
		call("UP2")
	END_CHANGE

	CHANGE(RING_DISPLAY)
		IF RING_DISPLAY.VAL==0
			GRINDING_TYPE.WR=4
		ELSE
			GRINDING_TYPE.WR=2
		ENDIF
	END_CHANGE

	CHANGE(GRINDING_TYPE)
		IF GRINDING_TYPE.VAL==1
			LM("MASK51","grind.com")
		ENDIF
	END_CHANGE

	SUB(UP2)
		IF QCHECK.VAL==1
			SCREW_R.WR=1
			VAR6.WR=1
			VAR7.WR=1
			VAR8.WR=1
			VAR9.WR=1
			VAR10.WR=1
			ZUIDU.WR=1
			X_QUIT.WR=1
			PITCH_COM.WR=1
			C_INIT.WR=1
			Z_INIT.WR=1
			SHOUJIAN.WR=1
			VAR23.WR=1
			IF VAR23.VAL==0
				VAR24.WR=1
				VAR25.WR=1
				VAR26.WR=1
				WORK_MID_DIA.WR=4
			ELSE
				VAR24.WR=1
				VAR25.WR=1
				VAR26.WR=1
				WORK_MID_DIA.WR=1
			ENDIF
		ELSE
			SCREW_R.WR=2
			VAR6.WR=2
			VAR7.WR=2
			VAR8.WR=2
			VAR9.WR=2
			ZUIDU.WR=2
			VAR10.WR=2
			X_QUIT.WR=2
			PITCH_COM.WR=2
			C_INIT.WR=2
			Z_INIT.WR=2
			SHOUJIAN.WR=2
			VAR23.WR=2
			IF VAR23.VAL==0
				VAR24.WR=2
				VAR25.WR=2
				VAR26.WR=2
				WORK_MID_DIA.WR=4
			ELSE
				VAR24.WR=1
				VAR25.WR=1
				VAR26.WR=1
				WORK_MID_DIA.WR=2
			ENDIF
		ENDIF
	END_SUB

	SUB(UP3)
		IF VAR23.VAL==1
			IF WORK_MID_DIA.VAL>0
				VAR24.VAL=SDEG(ATAN((VAR6.VAL*VAR7.VAL),(PI*WORK_MID_DIA.VAL)))
				VAR25.VAL=(SDEG(ATAN((VAR6.VAL*VAR7.VAL),(PI*WORK_MID_DIA.VAL)))-VAR24.VAL)*60
				VAR26.VAL=((SDEG(ATAN((VAR6.VAL*VAR7.VAL),(PI*WORK_MID_DIA.VAL)))-VAR24.VAL)*60-VAR25.VAL)*60
			ENDIF
		ENDIF
	END_SUB

//END
;ifIsInternalEnd

