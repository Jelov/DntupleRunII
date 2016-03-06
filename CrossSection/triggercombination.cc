#include "uti.h"
#include "parameters.h"
#include "TLegendEntry.h"
#include "TNtuple.h"
#include "TH1F.h"
#include "../TriggerStudies/triggerEfficiency.C"

using namespace std;


void triggercombination(TString ispp="PP",TString inputdata="/data/dmeson2015/DataDntuple/nt_20160112_DfinderData_pp_20160111_dPt0tkPt1_D0Dstar3p5p_DCSJSON_v2.root",int threshold=60, TString output="outputtestpp.root"){

  TFile* inf = new TFile(inputdata.Data());
  TTree* nt = (TTree*) inf->Get("ntDkpi");
  TTree* HltTree= (TTree*) inf->Get("ntHlt");
  HltTree->AddFriend(nt);
  nt->AddFriend(HltTree);
  
  TString cut=Form("Max$(Dpt)>%d",threshold);
  cout<<cut.Data()<<endl;

  TH1D* hPrescalesPtBins = new TH1D("hPrescalesPtBins","",nBins,ptBins);
  TH1D* hTriggerEfficiencyPtBins = new TH1D("hTriggerEfficiencyPtBins","",nBins,ptBins);
  
  TString triggerHLT[ntriggers];
   int triggerassignment[nBins];
  int triggerHLTthresholds[nBins];
  bool isPbPb;
  
  if(ispp=="PP"){
     for (int index=0; index<ntriggers;index++){
       triggerHLT[index]=triggerHLTPP[index];
       triggerHLTthresholds[index]=triggerHLTPPthresholds[index];
    }
     for (int index=0; index<nBins;index++) triggerassignment[index]=triggerassignmentPP[index];
     isPbPb=false;

  }
  if(ispp=="PbPb"){
     for (int index=0; index<ntriggers;index++){
       triggerHLT[index]=triggerHLTPbPb[index];
       triggerHLTthresholds[index]=triggerHLTPbPbthresholds[index];
    }
     for (int index=0; index<nBins;index++) triggerassignment[index]=triggerassignmentPbPb[index];
     isPbPb=true;

  }

  double ntriggerscounters[ntriggers];       
  double prescale[ntriggers];
  double errorprescale[ntriggers];
  double nflag[ntriggers];               
  double ncounters[ntriggers];
  double ncountersANDunprescaled[ntriggers];

  for (int index=0; index<ntriggers;index++){  
    ntriggerscounters[index]=0.;
    prescale[index]=0.;
    nflag[index]=0.;
    ncounters[index]=0.;
    ncountersANDunprescaled[index]=0.;
  }
  
  TH1D*hCountsPrescANDUnpresc[nBins];
  TH1D*hCountsUnpresc[nBins];
  
  for (int m=0;m<ntriggers;m++) {
  
    TString hnamePrescANDUnpresc=Form("hCountsPrescANDUnpresc_%d",m);
    TString hnameUnpresc=Form("hCountsUnpresc_%d",m);
    
    TString fillhistoPrescANDUnpresc=Form("%s>>%s",triggerHLT[m].Data(),hnamePrescANDUnpresc.Data());
    TString fillhistoUnpresc=Form("%s>>%s",triggerHLT[2].Data(),hnameUnpresc.Data());
    
    TString selPrescANDUnpresc=Form("%s&&%s&&%s",triggerHLT[m].Data(),triggerHLT[2].Data(),cut.Data());
    TString selUnpresc=Form("%s&&%s",triggerHLT[2].Data(),cut.Data());
    
    hCountsPrescANDUnpresc[m]=new TH1D(hnamePrescANDUnpresc.Data(),"histo",100,-0.5,2);
    hCountsUnpresc[m]=new TH1D(hnameUnpresc.Data(),"histo",100,-0.5,2);
    
    nt->Draw(fillhistoPrescANDUnpresc.Data(),selPrescANDUnpresc.Data());
    nt->Draw(fillhistoUnpresc.Data(),selUnpresc.Data());
    
    ncountersANDunprescaled[m]=hCountsPrescANDUnpresc[m]->GetEntries();
    ncounters[m]=hCountsUnpresc[m]->GetEntries();
    
  }
  
    for (int index=0; index<ntriggers;index++){
     prescale[index]=ncountersANDunprescaled[index]/ncounters[2];
     errorprescale[index]=1/ncounters[2]*TMath::Sqrt(ncountersANDunprescaled[index]*(1-(ncountersANDunprescaled[index]/ncounters[2])));
     cout<<"------index------"<<endl;
     cout<<"triggerHLT="<<triggerHLT[index]<<endl;
     cout<<"nuprescaled="<<ncounters[2]<<endl; 
     cout<<"ncountersANDunprescaled="<<ncountersANDunprescaled[index]<<endl; 
     cout<<"prescale="<<prescale[index]<<endl; 
     cout<<"error on prescale binomial="<<errorprescale[index]<<endl; 
     cout<<"relative error on prescale binomial="<<errorprescale[index]/prescale[index]<<endl; 
     
    }
    
    for (int index=0; index<nBins;index++){
     hPrescalesPtBins->SetBinContent(index+1,prescale[triggerassignment[index]]);
     hPrescalesPtBins->SetBinError(index+1,errorprescale[triggerassignment[index]]);
     double triggerefficiency=triggerEfficiency(hPrescalesPtBins->GetBinCenter(index+1),triggerHLTthresholds[triggerassignment[index]],isPbPb);
     std::cout<<"bin center="<<hPrescalesPtBins->GetBinCenter(index+1)<<", thresholds="<<triggerHLTthresholds[triggerassignment[index]]<<",isPbPb="<<isPbPb<<", efficiency="<<triggerefficiency<<std::endl;
     hTriggerEfficiencyPtBins->SetBinContent(index+1,triggerefficiency);
     
    }
    hTriggerEfficiencyPtBins->Draw();
    TFile*foutput=new TFile(output.Data(),"recreate");
    foutput->cd();
    hPrescalesPtBins->Write();
    hTriggerEfficiencyPtBins->Write();
    
}


int main(int argc, char *argv[])
{
  if((argc != 5))
  {
    std::cout << "Wrong number of inputs" << std::endl;
    return 1;
  }

  if(argc == 5)
    triggercombination(argv[1],argv[2],atoi(argv[3]),argv[4]);
  return 0;
}


