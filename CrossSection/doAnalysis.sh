#!/bin/bash
#source clean.sh

DOFONLL=0
DOTRGCOMBINATION=0
DOFEEDDOWN=0
DOFITSPP=0
DOFITSPPMCClosure=0
DOFITSPbPb=0
DOMCstudyPP=0
DOMCstudyPPReweight=1
DOMCstudyNPPP=0
DOMCstudyPbPb=0
DOMCstudyPbPbReweight=0
DOCrossSectionPP=0
DOCrossSectionPbPb=0
DORAA=0

DOFONLLMB=0
DOFEEDDOWNMB=0
DOFITSPPMB=0
DOFITSPbPbMB=0
DOMCstudyPPMB=0
DOMCstudyPPMBReweight=0
DOMCstudyPbPbMB=0
DOMCstudyPbPbMBReweight=0
DOCrossSectionPPMB=0
DOCrossSectionPbPbMB=0
DORAAMB=0

DOCombineCrossSection=0
DOCombineRAA=0

UNITY=1
FONLLDATINPUT="pp_d0meson_5TeV_y1"
FONLLDATINPUTBtoD="pp_Btod0meson_5TeV_y1"
FONLLDATINPUTB="pp_Bmeson_5TeV_y1"

NTUPLAPYTHIA="/data/HeavyFlavourRun2/BtoDPythia/treefile_ptall_11january2016.root"
INPUTMCPP="/data/wangj/MC2015/Dntuple/pp/revised/ntD_pp_Dzero_kpi_prompt/ntD_EvtBase_20160303_Dfinder_20160302_pp_Pythia8_prompt_D0_dPt0tkPt0p5_pthatweight.root"  
#INPUTMCPP="/data/wangj/MC2015/Dntuple/pp/ntD_pp_Dzero_kpi_prompt/ntD_EvtBase_20160229_Dfinder_20160215_pp_Pythia8_prompt_D0_dPt0tkPt0p5_pthatweight.root"
INPUTMCNPPP="/data/wangj/MC2015/Dntuple/pp/ntD_pp_Dzero_kpi_nonprompt/ntD_EvtBase_20160229_Dfinder_20160215_pp_Pythia8_nonprompt_D0_dPt0tkPt0p5_pthatweight.root"
INPUTDATAPP="/data/dmeson2015/DataDntuple/nt_20160112_DfinderData_pp_20160111_dPt0tkPt1_D0Dstar3p5p_DCSJSON_v2_skimmed.root"
INPUTDATAPPUNSKIMMED="/data/dmeson2015/DataDntuple/nt_20160112_DfinderData_pp_20160111_dPt0tkPt1_D0Dstar3p5p_DCSJSON_v2.root"
INPUTMCPbPb="/data/wangj/MC2015/Dntuple/pp/revised/ntD_pp_Dzero_kpi_prompt/ntD_EvtBase_20160303_Dfinder_20160302_pp_Pythia8_prompt_D0_dPt0tkPt0p5_pthatweight.root"
#INPUTMCPbPb="/data/wangj/MC2015/Dntuple/pp/ntD_pp_Dzero_kpi_prompt/ntD_EvtBase_20160229_Dfinder_20160215_pp_Pythia8_prompt_D0_dPt0tkPt0p5_pthatweight.root"
INPUTDATAPbPb="/data/dmeson2015/DataDntuple/nt_skimmed_DfinderData_PbPb_20160126_dPt0tkPt2p5_D0Dstar3p5p_FINALJSON_v6_partialstats_v2_skimmed.root"
INPUTDATAPbPbUNSKIMMED="/data/dmeson2015/DataDntuple/nt_skimmed_DfinderData_PbPb_20160126_dPt0tkPt2p5_D0Dstar3p5p_FINALJSON_v6_partialstats_v2.root"

FONLLOUTPUTFILE="ROOTfiles/output_pp_d0meson_5TeV_y1.root"
FONLLOUTPUTFILEBtoD="ROOTfiles/output_pp_Btod0meson_5TeV_y1.root"
FONLLOUTPUTFILEInclusiveD="ROOTfiles/output_inclusiveDd0meson_5TeV_y1.root"
FONLLOUTPUTFILEB="ROOTfiles/output_pp_Bmeson_5TeV_y1.root"
OUTPUTFILEPP="ROOTfiles/hPtSpectrumDzeroPP.root"
OUTPUTFILEPPMCClosure="ROOTfiles/hPtSpectrumDzeroPPMCClosure.root"
OUTPUTFILEPlotPP="ROOTfiles/CrossSectionFONLLPP.root"
OUTPUTFILEPbPb="ROOTfiles/hPtSpectrumDzeroPbPb.root"
OUTPUTFILEPlotPbPb="ROOTfiles/CrossSectionFONLLPbPb.root"
OUTPUTFILERAA="ROOTfiles/outputRAA.root"
OUTPUTFILEMCSTUDYPP="ROOTfiles/MCstudiesPP"
OUTPUTFILEMCSTUDYNPPP="ROOTfiles/MCstudiesNPPP"
OUTPUTFILEMCSTUDYPbPb="ROOTfiles/MCstudiesPbPb"

LUMIPP=26.31
ISMCPP=0
ISDOWEIGHTPP=0
SELGENPP="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))"
SELGENPPACCPP="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))&&abs(Gtk1eta)<2.0&&abs(Gtk2eta)<2.0&&Gtk1pt>2.0&&Gtk2pt>2.0"
RECOONLYPP="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>2.0&&Dtrk2Pt>2.0&&Dtrk1PtErr/Dtrk1Pt<0.1&&Dtrk2PtErr/Dtrk2Pt<0.1&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0&&Dtrk1Algo>3&&Dtrk1Algo<8&&Dtrk2Algo>3&&Dtrk2Algo<8&&(Dtrk1PixelHit+Dtrk1StripHit)>=11&&(Dtrk2PixelHit+Dtrk2StripHit)>=11&&(Dtrk1Chi2ndf/(Dtrk1nStripLayer+Dtrk1nPixelLayer)<0.15)&&(Dtrk2Chi2ndf/(Dtrk2nStripLayer+Dtrk2nPixelLayer)<0.15)"
CUTPP="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>2.0&&Dtrk2Pt>2.0&&(DsvpvDistance/DsvpvDisErr)>3.5&&(DlxyBS/DlxyBSErr)>1.5&&Dchi2cl>0.05&&Dalpha<0.12&&Dtrk1PtErr/Dtrk1Pt<0.1&&Dtrk2PtErr/Dtrk2Pt<0.1&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0&&Dtrk1Algo>3&&Dtrk1Algo<8&&Dtrk2Algo>3&&Dtrk2Algo<8&&(Dtrk1PixelHit+Dtrk1StripHit)>=11&&(Dtrk2PixelHit+Dtrk2StripHit)>=11&&(Dtrk1Chi2ndf/(Dtrk1nStripLayer+Dtrk1nPixelLayer)<0.15)&&(Dtrk2Chi2ndf/(Dtrk2nStripLayer+Dtrk2nPixelLayer)<0.15)"
TRGPP="((HLT_DmesonPPTrackingGlobal_Dpt15_v1&&Dpt>20&&Dpt<40)||(HLT_DmesonPPTrackingGlobal_Dpt30_v1&&Dpt>40&&Dpt<60)||(HLT_DmesonPPTrackingGlobal_Dpt50_v1&&Dpt>60))"
LABELPP="PP"
LABELNPPP="NPPP"
USEPRESCALEPP=1
CUTFORTRIGGERPRESCALEPP=0

LUMIPPMCClosure=1
ISMCPPMCClosure=1
ISDOWEIGHTPPMCClosure=1
TRGPPMCClosure="1"
LABELPPMCClosure="PPMCClosure"

                                         
LUMIPbPb=0.000404 #404*0.001*0.001
ISMCPbPb=0
ISDOWEIGHTPbPb=0
SELGENPbPb="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))"
SELGENPPACCPbPb="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))&&abs(Gtk1eta)<2.0&&abs(Gtk2eta)<2.0&&Gtk1pt>2.0&&Gtk2pt>2.0"
RECOONLYPbPb="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>8.5&&Dtrk2Pt>8.5&&Dtrk1PtErr/Dtrk1Pt<0.1&&Dtrk2PtErr/Dtrk2Pt<0.1&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0&&(Dtrk1PixelHit+Dtrk1StripHit)>=11&&(Dtrk2PixelHit+Dtrk2StripHit)>=11&&(Dtrk1Chi2ndf/(Dtrk1nStripLayer+Dtrk1nPixelLayer)<0.15)&&(Dtrk2Chi2ndf/(Dtrk2nStripLayer+Dtrk2nPixelLayer)<0.15)"
CUTPbPb="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>8.5&&Dtrk2Pt>8.5&&(DsvpvDistance/DsvpvDisErr)>3.5&&(DlxyBS/DlxyBSErr)>2.5&&Dchi2cl>0.05&&Dalpha<0.12&&Dtrk1PtErr/Dtrk1Pt<0.1&&Dtrk2PtErr/Dtrk2Pt<0.1&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0&&(Dtrk1PixelHit+Dtrk1StripHit)>=11&&(Dtrk2PixelHit+Dtrk2StripHit)>=11&&(Dtrk1Chi2ndf/(Dtrk1nStripLayer+Dtrk1nPixelLayer)<0.15)&&(Dtrk2Chi2ndf/(Dtrk2nStripLayer+Dtrk2nPixelLayer)<0.15)"
TRGPbPb="((HLT_HIDmesonHITrackingGlobal_Dpt20_v1&&Dpt>20&&Dpt<45)||(HLT_HIDmesonHITrackingGlobal_Dpt40_v1&&Dpt>45&&Dpt<70)||(HLT_HIDmesonHITrackingGlobal_Dpt60_v1&&Dpt>70))"
LABELPbPb="PbPb"
USEPRESCALEPbPb=1
CUTFORTRIGGERPRESCALEPbPb=70

OUTPUTPrescalePP="prescalePP.root"
OUTPUTPrescalePbPb="prescalePbPb.root"

cp config/parametersHighpt.h parameters.h

if [ $DOFONLL -eq 1 ]; then      

g++ Dzerodsigmadpt.cc $(root-config --cflags --libs) -g -o Dzerodsigmadpt.exe 
./Dzerodsigmadpt.exe "$FONLLDATINPUT"  "$FONLLOUTPUTFILE" "$LABELPP"
./Dzerodsigmadpt.exe "$FONLLDATINPUTBtoD"  "$FONLLOUTPUTFILEBtoD" "$LABELPP"

g++ BplusAlldsigmadpt.cc $(root-config --cflags --libs) -g -o BplusAlldsigmadpt.exe 
./BplusAlldsigmadpt.exe "$FONLLDATINPUTB"  "$FONLLOUTPUTFILEB" "$LABELPP"
fi 

if [ $DOFEEDDOWN -eq 1 ]; then      

g++ RatioFeedDown.cc $(root-config --cflags --libs) -g -o RatioFeedDown.exe 
./RatioFeedDown.exe "$FONLLOUTPUTFILE"  "$FONLLOUTPUTFILEBtoD" "$FONLLOUTPUTFILEInclusiveD" "$LABELPP"

g++ plotFeedDown.C $(root-config --cflags --libs) -g -o plotFeedDown.exe 
./plotFeedDown.exe "$FONLLOUTPUTFILE"  "$FONLLOUTPUTFILEB" "$NTUPLAPYTHIA" 1 0 100 

fi

if [ $DOTRGCOMBINATION -eq 1 ]; then      

g++ triggercombination.cc $(root-config --cflags --libs) -g -o triggercombination.exe 
./triggercombination.exe "$LABELPP"  "$INPUTDATAPPUNSKIMMED" "$CUTFORTRIGGERPRESCALEPP" "$OUTPUTPrescalePP"

g++ triggercombination.cc $(root-config --cflags --libs) -g -o triggercombination.exe 
./triggercombination.exe "$LABELPbPb"  "$INPUTDATAPbPbUNSKIMMED" "$CUTFORTRIGGERPRESCALEPbPb" "$OUTPUTPrescalePbPb"
fi

if [ $DOFITSPP -eq 1 ]; then      
g++ fitD.C $(root-config --cflags --libs) -g -o fitD.exe 
./fitD.exe "$INPUTDATAPP"  "$INPUTMCPP"  "$TRGPP" "$CUTPP"   "$SELGENPP"   "$ISMCPP"   "$LUMIPP"   "$ISDOWEIGHTPP"   "$LABELPP"  "$OUTPUTFILEPP"
fi

if [ $DOFITSPPMCClosure -eq 1 ]; then      
g++ fitD.C $(root-config --cflags --libs) -g -o fitD.exe 
./fitD.exe "$INPUTMCPP"  "$INPUTMCPP"  "$TRGPPMCClosure" "$CUTPP"   "$SELGENPP"   "$ISMCPPMCClosure"   "$LUMIPPMCClosure"   "$ISMCPPMCClosure"   "$LABELPPMCClosure"  "$OUTPUTFILEPPMCClosure"
fi


if [ $DOFITSPbPb -eq 1 ]; then      
g++ fitD.C $(root-config --cflags --libs) -g -o fitD.exe 
./fitD.exe "$INPUTDATAPbPb"  "$INPUTMCPbPb"  "$TRGPbPb" "$CUTPbPb"   "$SELGENPbPb"   "$ISMCPbPb"   "$LUMIPbPb"   "$ISDOWEIGHTPbPb"  "$LABELPbPb"  "$OUTPUTFILEPbPb"
fi

if [ $DOMCstudyPP -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPP"  "$SELGENPP" "$SELGENPPACCPP"  "$RECOONLYPP" "$CUTPP"  "$LABELPP" "$OUTPUTFILEMCSTUDYPP" "$ISDOWEIGHTPP"
fi

if [ $DOMCstudyPPReweight -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPP"  "$SELGENPP" "$SELGENPPACCPP"  "$RECOONLYPP" "$CUTPP"  "$LABELPP" "$OUTPUTFILEMCSTUDYPP" "$UNITY"
fi


if [ $DOMCstudyNPPP -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCNPPP"  "$SELGENPP" "$SELGENPPACCPP"  "$RECOONLYPP" "$CUTPP"  "$LABELNPPP" "$OUTPUTFILEMCSTUDYNPPP" "$ISDOWEIGHTPP"
fi


if [ $DOMCstudyPbPbReweight -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPbPb"  "$SELGENPbPb" "$SELGENPPACCPbPb"  "$RECOONLYPbPb" "$CUTPbPb"  "$LABELPbPb" "$OUTPUTFILEMCSTUDYPbPb" "$UNITY"
fi

if [ $DOMCstudyPbPb -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPbPb"  "$SELGENPbPb" "$SELGENPPACCPbPb"  "$RECOONLYPbPb" "$CUTPbPb"  "$LABELPbPb" "$OUTPUTFILEMCSTUDYPbPb" "$ISDOWEIGHTPbPb"
fi


if [ $DOCrossSectionPP -eq 1 ]; then      
g++ CrossSectionRatio.C $(root-config --cflags --libs) -g -o CrossSectionRatio.exe 
./CrossSectionRatio.exe "$FONLLOUTPUTFILEInclusiveD"  "$OUTPUTFILEPP" "$OUTPUTPrescalePP" "$USEPRESCALEPP" "$OUTPUTFILEPlotPP" "$LABELPP"
fi

if [ $DOCrossSectionPbPb -eq 1 ]; then      
g++ CrossSectionRatio.C $(root-config --cflags --libs) -g -o CrossSectionRatio.exe 
./CrossSectionRatio.exe "$FONLLOUTPUTFILEInclusiveD"  "$OUTPUTFILEPbPb" "$OUTPUTPrescalePbPb" "$USEPRESCALEPbPb" "$OUTPUTFILEPlotPbPb" "$LABELPbPb"
fi

if [ $DORAA -eq 1 ]; then      
g++ NuclearModificationFactor.C $(root-config --cflags --libs) -g -o NuclearModificationFactor.exe 
./NuclearModificationFactor.exe "$OUTPUTFILEPlotPP" "$OUTPUTFILEPlotPbPb"  "$LABELPbPb" "$OUTPUTFILERAA" 
fi

INPUTDATAPPMBUNSKIMMED="/data/jisun/ppMB2015fullstats/skim_ncand_D0Dntuple_crab_pp_ALLMinimumBias_AOD_D0_tkpt0p5_Ds_01212016.root"
INPUTDATAPPMB="/data/dmeson2015/DataDntuple/skim_ncand_D0Dntuple_crab_pp_ALLMinimumBias_AOD_D0_tkpt0p5_Ds_01212016_skimmed.root"
INPUTDATAPbPbMBUNSKIMMED="/data/jisun/PbPb2015/Dntuple_crab_PbPb_HIMinimumBias3_ForestAOD_D0_tkpt0p7eta1p5_goldenjson_01292016.root"
INPUTDATAPbPbMB="/data/dmeson2015/DataDntuple/Dntuple_crab_PbPb_HIMinimumBias3_ForestAOD_D0_tkpt0p7eta1p5_goldenjson_01292016_skim.root"


FONLLOUTPUTFILEMB="ROOTfiles/output_pp_d0meson_5TeV_y1MB.root"
FONLLOUTPUTFILEBtoDMB="ROOTfiles/output_pp_Btod0meson_5TeV_y1MB.root"
FONLLOUTPUTFILEInclusiveDMB="ROOTfiles/output_inclusiveDd0meson_5TeV_y1MB.root"
FONLLOUTPUTFILEBMB="ROOTfiles/output_pp_Bmeson_5TeV_y1MB.root"
OUTPUTFILEPPMB="ROOTfiles/hPtSpectrumDzeroPPMB.root"
OUTPUTFILEPPMCClosureMB="ROOTfiles/hPtSpectrumDzeroPPMCClosureMB.root"
OUTPUTFILEPlotPPMB="ROOTfiles/CrossSectionFONLLPPMB.root"
OUTPUTFILEPbPbMB="ROOTfiles/hPtSpectrumDzeroPbPbMB.root"
OUTPUTFILEPlotPbPbMB="ROOTfiles/CrossSectionFONLLPbPbMB.root"
OUTPUTFILERAAMB="ROOTfiles/outputRAAMB.root"
OUTPUTFILEMCSTUDYPPMB="ROOTfiles/MCstudiesPPMB"
OUTPUTFILEMCSTUDYPbPbMB="ROOTfiles/MCstudiesPbPbMB"


LUMIPPMB=0.0351        #assuming sigma=70mb, Nevents=2213 millions, estimated MB efficiency=0.9  Lumi=2.213*10^9/(70*0.85*10^9pb)=2.213/(70*0.9)=0.0351
ISMCPPMB=0
ISDOWEIGHTPPMB=0
SELGENPPMB="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))"
SELGENACCPPMB="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))&&abs(Gtk1eta)<2.0&&abs(Gtk2eta)<2.0&&Gtk1pt>1.0&&Gtk2pt>1.0"
RECOONLYPPMB="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>1.0&&Dtrk2Pt>1.0&&Dtrk1PtErr/Dtrk1Pt<0.3&&Dtrk2PtErr/Dtrk2Pt<0.3&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0"
CUTPPMB="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>1.0&&Dtrk2Pt>1.0&&Dtrk1PtErr/Dtrk1Pt<0.3&&Dtrk2PtErr/Dtrk2Pt<0.3&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0&&(DsvpvDistance/DsvpvDisErr)>3.5&&(DlxyBS/DlxyBSErr)>1.5&&Dchi2cl>0.05&&Dalpha<0.12"
TRGPPMB="(HLT_L1MinimumBiasHF1OR_part1_v1||HLT_L1MinimumBiasHF1OR_part2_v1||HLT_L1MinimumBiasHF1OR_part3_v1||HLT_L1MinimumBiasHF1OR_part4_v1||HLT_L1MinimumBiasHF1OR_part5_v1||HLT_L1MinimumBiasHF1OR_part6_v1||HLT_L1MinimumBiasHF1OR_part7_v1||HLT_L1MinimumBiasHF1OR_part8_v1||HLT_L1MinimumBiasHF1OR_part9_v1||HLT_L1MinimumBiasHF1OR_part10_v1||HLT_L1MinimumBiasHF1OR_part11_v1||HLT_L1MinimumBiasHF1OR_part12_v1||HLT_L1MinimumBiasHF1OR_part13_v1||HLT_L1MinimumBiasHF1OR_part14_v1||HLT_L1MinimumBiasHF1OR_part15_v1||HLT_L1MinimumBiasHF1OR_part16_v1||HLT_L1MinimumBiasHF1OR_part17_v1||HLT_L1MinimumBiasHF1OR_part18_v1||HLT_L1MinimumBiasHF1OR_part19_v1)"
LABELPPMB="PPMB"
USEPRESCALEPPMB=0


LUMIPbPbMB=0.0000072        #assuming sigma=7750 mb, Nevents=50.283009 millions, estimated MB efficiency=0.9  Lumi=0.05028*10^9/(7750*0.90*10^9pb)=0.05028/(7750*0.9)=7.20*1e-6
ISMCPbPbMB=0
ISDOWEIGHTPbPbMB=0
SELGENPbPbMB="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))"
SELGENACCPbPbMB="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))&&abs(Gtk1eta)<1.5&&abs(Gtk2eta)<1.5&&Gtk1pt>1.0&&Gtk2pt>1.0"
RECOONLYPbPbMB="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>1.0&&Dtrk2Pt>1.0&&Dtrk1PtErr/Dtrk1Pt<0.3&&Dtrk2PtErr/Dtrk2Pt<0.3&&abs(Dtrk1Eta)<1.5&&abs(Dtrk2Eta)<1.5"
CUTPbPbMB="Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>1.0&&Dtrk2Pt>1.0&&Dtrk1PtErr/Dtrk1Pt<0.3&&Dtrk2PtErr/Dtrk2Pt<0.3&&abs(Dtrk1Eta)<1.5&&abs(Dtrk2Eta)<1.5&&(DsvpvDistance/DsvpvDisErr)>5.0&&(DlxyBS/DlxyBSErr)>1.5&&Dchi2cl>0.05&&Dalpha<0.12"
TRGPbPbMB="(HLT_HIL1MinimumBiasHF2AND_part1_v1||HLT_HIL1MinimumBiasHF2AND_part2_v1||HLT_HIL1MinimumBiasHF2AND_part3_v1)"
LABELPbPbMB="PbPbMB"
USEPRESCALEPbPbMB=0

cp config/parametersLowpt.h parameters.h

if [ $DOFONLLMB -eq 1 ]; then      

g++ Dzerodsigmadpt.cc $(root-config --cflags --libs) -g -o Dzerodsigmadpt.exe 
./Dzerodsigmadpt.exe "$FONLLDATINPUT"  "$FONLLOUTPUTFILEMB" "$LABELPPMB"
./Dzerodsigmadpt.exe "$FONLLDATINPUTBtoD"  "$FONLLOUTPUTFILEBtoDMB" "$LABELPPMB"

g++ BplusAlldsigmadpt.cc $(root-config --cflags --libs) -g -o BplusAlldsigmadpt.exe 
./BplusAlldsigmadpt.exe "$FONLLDATINPUTB"  "$FONLLOUTPUTFILEBMB" "$LABELPPMB"
fi 

if [ $DOFEEDDOWNMB -eq 1 ]; then      

g++ RatioFeedDown.cc $(root-config --cflags --libs) -g -o RatioFeedDown.exe 
./RatioFeedDown.exe "$FONLLOUTPUTFILEMB"  "$FONLLOUTPUTFILEBtoDMB" "$FONLLOUTPUTFILEInclusiveDMB" "$LABELPPMB"

g++ plotFeedDown.C $(root-config --cflags --libs) -g -o plotFeedDown.exe 
./plotFeedDown.exe "$FONLLOUTPUTFILEMB"  "$FONLLOUTPUTFILEBMB" "$NTUPLAPYTHIA" 1 0 100 

fi

if [ $DOFITSPPMB -eq 1 ]; then      
g++ fitD.C $(root-config --cflags --libs) -g -o fitD.exe 
./fitD.exe "$INPUTDATAPPMB"  "$INPUTMCPP"  "$TRGPPMB" "$CUTPPMB"   "$SELGENPPMB"   "$ISMCPPMB"   "$LUMIPPMB"   "$ISDOWEIGHTPPMB"   "$LABELPPMB"  "$OUTPUTFILEPPMB"
fi

if [ $DOFITSPbPbMB -eq 1 ]; then      
g++ fitD.C $(root-config --cflags --libs) -g -o fitD.exe 
./fitD.exe "$INPUTDATAPbPbMB"  "$INPUTMCPbPb"  "$TRGPbPbMB" "$CUTPbPbMB"   "$SELGENPbPbMB"   "$ISMCPbPbMB"   "$LUMIPbPbMB"   "$ISDOWEIGHTPbPbMB"   "$LABELPbPbMB"  "$OUTPUTFILEPbPbMB"
fi

if [ $DOMCstudyPPMB -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPP"  "$SELGENPPMB" "$SELGENACCPPMB"  "$RECOONLYPPMB" "$CUTPPMB"  "$LABELPPMB" "$OUTPUTFILEMCSTUDYPPMB" "$ISDOWEIGHTPPMB"
fi

if [ $DOMCstudyPPMBReweight -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPP"  "$SELGENPPMB" "$SELGENACCPPMB"  "$RECOONLYPPMB" "$CUTPPMB"  "$LABELPPMB" "$OUTPUTFILEMCSTUDYPPMB" "$UNITY"
fi

if [ $DOMCstudyPbPbMB -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPbPb"  "$SELGENPbPbMB" "$SELGENACCPbPbMB"  "$RECOONLYPbPbMB" "$CUTPbPbMB"  "$LABELPbPbMB" "$OUTPUTFILEMCSTUDYPbPbMB" "$ISDOWEIGHTPbPbMB"
fi

if [ $DOMCstudyPbPbMBReweight -eq 1 ]; then      
g++ MCefficiency.C $(root-config --cflags --libs) -g -o MCefficiency.exe 
./MCefficiency.exe "$INPUTMCPbPb"  "$SELGENPbPbMB" "$SELGENACCPbPbMB"  "$RECOONLYPbPbMB" "$CUTPbPbMB"  "$LABELPbPbMB" "$OUTPUTFILEMCSTUDYPbPbMB" "$UNITY"
fi


if [ $DOCrossSectionPPMB -eq 1 ]; then      
g++ CrossSectionRatio.C $(root-config --cflags --libs) -g -o CrossSectionRatio.exe 
./CrossSectionRatio.exe "$FONLLOUTPUTFILEInclusiveDMB"  "$OUTPUTFILEPPMB" "$OUTPUTPrescalePP" "$USEPRESCALEPPMB" "$OUTPUTFILEPlotPPMB" "$LABELPPMB"
fi

if [ $DOCrossSectionPbPbMB -eq 1 ]; then      
g++ CrossSectionRatio.C $(root-config --cflags --libs) -g -o CrossSectionRatio.exe 
./CrossSectionRatio.exe "$FONLLOUTPUTFILEInclusiveDMB"  "$OUTPUTFILEPbPbMB" "$OUTPUTPrescalePP" "$USEPRESCALEPbPbMB" "$OUTPUTFILEPlotPbPbMB" "$LABELPbPbMB"
fi

if [ $DORAAMB -eq 1 ]; then      
g++ NuclearModificationFactor.C $(root-config --cflags --libs) -g -o NuclearModificationFactor.exe 
./NuclearModificationFactor.exe "$OUTPUTFILEPlotPPMB" "$OUTPUTFILEPlotPbPbMB" "$LABELPbPbMB" "$OUTPUTFILERAAMB"
fi

if [ $DOCombineCrossSection -eq 1 ]; then      
g++ CombineCrossSections.C $(root-config --cflags --libs) -g -o CombineCrossSections.exe 
./CombineCrossSections.exe "$OUTPUTFILEPlotPPMB" "$OUTPUTFILEPlotPP" 
fi

CHARGEDHADRON="/afs/cern.ch/work/g/ginnocen/public/PlotRAA.root" 

if [ $DOCombineRAA -eq 1 ]; then      
g++ CombineRAA.C $(root-config --cflags --libs) -g -o CombineRAA.exe 
./CombineRAA.exe "$OUTPUTFILERAAMB" "$OUTPUTFILERAA" "$CHARGEDHADRON"
fi


