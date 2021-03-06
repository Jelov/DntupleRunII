#include "uti.h"
#include "parameters.h"

Double_t setparam0=100.;
Double_t setparam1=1.865;
Double_t setparam2=0.03;
Double_t setparam10=0.005;
Double_t setparam8=0.1;
Double_t setparam9=0.1;
Double_t fixparam1=1.865;
Double_t minhisto=	1.7;
Double_t maxhisto=2.0;
Double_t nbinsmasshisto=60;
Double_t binwidthmass=(maxhisto-minhisto)/nbinsmasshisto;

TString weight = "pthatweight";
TString seldata;
TString selmc;
TString collisionsystem;

void fitDVariable(TString variable="DsvpvDistance/DsvpvDisErr",TString variableplot="d_{xy}/#sigma(d_{xy})", TString inputdata="/data/wangj/MC2015/Dntuple/pp/ntD_pp_Dzero_kpi/ntD_EvtBase_20160203_Dfinder_20160201_pp_Pythia8_prompt_D0_dPt0tkPt0p5_pthatweight.root", TString inputmc="/data/wangj/MC2015/Dntuple/pp/ntD_pp_Dzero_kpi/ntD_EvtBase_20160203_Dfinder_20160201_pp_Pythia8_prompt_D0_dPt0tkPt0p5_pthatweight.root", TString trgselection="1",  TString cut="Dpt>20&&Dy>-1.&&Dy<1.&&Dtrk1highPurity&&Dtrk2highPurity&&Dtrk1Pt>2.0&&Dtrk2Pt>2.0&&(DsvpvDistance/DsvpvDisErr)>3&&(DlxyBS/DlxyBSErr)>1.5&&Dchi2cl>0.05&&Dalpha<0.12&&Dtrk1PtErr/Dtrk1Pt<0.1&&Dtrk2PtErr/Dtrk2Pt<0.1&&abs(Dtrk1Eta)<2.0&&abs(Dtrk2Eta)<2.0&&Dtrk1Algo>3&&Dtrk1Algo<8&&(Dtrk1PixelHit+Dtrk1StripHit)>=11", TString selmcgen="((GisSignal==1||GisSignal==2)&&(Gy>-1&&Gy<1))", int isMC=1, Double_t luminosity=26., int doweight=0, TString collsyst="PbPb", TString outputfile="mytest.root", TString _weight="pthatweight")
{
  weight = _weight;
  collisionsystem=collsyst;
  seldata = Form("%s&&%s",trgselection.Data(),cut.Data());
  selmc = Form("%s",cut.Data());

  gStyle->SetTextSize(0.05);
  gStyle->SetTextFont(42);
  gStyle->SetPadRightMargin(0.043);
  gStyle->SetPadLeftMargin(0.18);
  gStyle->SetPadTopMargin(0.1);
  gStyle->SetPadBottomMargin(0.145);
  gStyle->SetTitleX(.0f);

  void clean0 (TH1D* h);
  TF1* fit (TString variable, TString variableplot, TTree* nt, TTree* ntMC, double ptmin, double ptmax, int isMC);

  if(!doweight) weight="1";
  TFile* inf = new TFile(inputdata.Data());
  TFile* infMC = new TFile(inputmc.Data());

  TTree* nt = (TTree*) inf->Get("ntDkpi");
  TTree* HltTree= (TTree*) inf->Get("ntHlt");
  HltTree->AddFriend(nt);
  nt->AddFriend(HltTree);
  TTree* ntHid = (TTree*) inf->Get("ntHi");
  nt->AddFriend(ntHid);
  
  TTree* ntMC = (TTree*)infMC->Get("ntDkpi");
  TTree* ntGen = (TTree*)infMC->Get("ntGen");
  TTree* ntHi = (TTree*)infMC->Get("ntHi");
  
  ntGen->AddFriend(ntMC);
  ntGen->AddFriend(ntHi);
  ntMC->AddFriend(ntGen);
  ntMC->AddFriend(ntHi);
  ntHi->AddFriend(ntMC);
  
  TH1D* hPt = new TH1D("hPt","",nBins,ptBins);
  TH1D* hPtRecoTruth = new TH1D("hPtRecoTruth","",nBins,ptBins);
  TH1D* hPtMC = new TH1D("hPtMC","",nBins,ptBins);
  TH1D* hPtGen = new TH1D("hPtGen","",nBins,ptBins);

  TH1D* hMean = new TH1D("hMean","",nBins,ptBins);                       
  TH1D* hSigmaGaus1 = new TH1D("hSigmaGaus1","",nBins,ptBins); 
  TH1D* hSigmaGaus2 = new TH1D("hSigmaGaus2","",nBins,ptBins); 
  TH1D* hRelMagnGaus1Gaus2 = new TH1D("hRelMagnGaus1Gaus2","",nBins,ptBins); 
  
  for(int i=0;i<nBins;i++)
    {
      TF1* f = fit(variable,variableplot,nt,ntMC,ptBins[i],ptBins[i+1],isMC);
      double yield = f->Integral(minhisto,maxhisto)/binwidthmass;
      double yieldErr = f->Integral(minhisto,maxhisto)/binwidthmass*f->GetParError(0)/f->GetParameter(0);
      hPt->SetBinContent(i+1,yield/(ptBins[i+1]-ptBins[i]));
      hPt->SetBinError(i+1,yieldErr/(ptBins[i+1]-ptBins[i]));
      hMean->SetBinContent(i+1,f->GetParameter(1));
      hMean->SetBinError(i+1,f->GetParError(1));
      hSigmaGaus1->SetBinContent(i+1,f->GetParameter(2));
      hSigmaGaus1->SetBinError(i+1,f->GetParError(2));
      hSigmaGaus2->SetBinContent(i+1,f->GetParameter(5));
      hSigmaGaus2->SetBinError(i+1,f->GetParError(5));
      hRelMagnGaus1Gaus2->SetBinContent(i+1,f->GetParameter(4));
      hRelMagnGaus1Gaus2->SetBinError(i+1,f->GetParError(4));
    }  

  ntMC->Project("hPtMC",variable.Data(),TCut(weight)*(TCut(selmc.Data())&&"(Dgen==23333)"));
  divideBinWidth(hPtMC);
  ntMC->Project("hPtRecoTruth",variable.Data(),TCut(selmc.Data())&&"(Dgen==23333)");
  divideBinWidth(hPtRecoTruth);
  ntGen->Project("hPtGen","Gpt",TCut(weight)*(TCut(selmcgen.Data())));
  divideBinWidth(hPtGen);

  TCanvas* cPt =  new TCanvas("cPt","",600,600);
  cPt->SetLogy();
  hPt->SetXTitle(Form("D^{0} %s",variable.Data()));
  hPt->SetYTitle("Uncorrected dN(D^{0})/dp_{T}");
  hPt->Sumw2();
  hPt->Draw();
  if(isMC)
    {
      hPtMC->Draw("same hist");
      TLegend* legPt = myLegend(0.55,0.80,0.90,0.94);
      legPt->AddEntry(hPt,"Signal extraction","pl");
      legPt->AddEntry(hPtMC,"Matched reco","lf");
      legPt->Draw("same");  
    }
  hPtMC->Sumw2();
  TH1D* hEff = (TH1D*)hPtMC->Clone("hEff");
  hEff->SetTitle(Form(";D^{0} %s",variable.Data()));
  hEff->Sumw2();
  hEff->Divide(hPtGen);
  TCanvas* cEff = new TCanvas("cEff","",600,600);
  hEff->Draw();
  
  TH1D* hPtCor = (TH1D*)hPt->Clone("hPtCor");
  hPtCor->SetTitle(Form(";D^{0} %s;Corrected dN(D^{0})/dp_{T}",variable.Data()));
  hPtCor->Divide(hEff);
  TCanvas* cPtCor=  new TCanvas("cCorResult","",600,600);
  cPtCor->SetLogy();
  hPtCor->Draw();
  if(isMC)
    {
      hPtGen->Draw("same hist");
      TLegend* legPtCor = myLegend(0.55,0.80,0.90,0.94);
      legPtCor->AddEntry(hPtCor,"Corrected signal","pl");
      legPtCor->AddEntry(hPtGen,"Generated D^{0}","lf");
      legPtCor->Draw("same");  
    }

  TH1D* hPtSigma= (TH1D*)hPtCor->Clone("hPtSigma");
  hPtSigma->SetTitle(Form(";D^{0} %s;d#sigma(D^{0})/d%s (pb/{units})",variable.Data(),variable.Data()));
  hPtSigma->Scale(1./(2*luminosity*BRchain));
  TCanvas* cPtSigma=  new TCanvas("cPtSigma","",600,600);
  cPtSigma->SetLogy();
  hPtSigma->Draw();
  
  TFile* outf = new TFile(outputfile.Data(),"recreate");
  outf->cd();
  hPt->Write();
  hEff->Write();
  hPtGen->Write();
  hPtMC->Write();
  hPtCor->Write();
  hPtSigma->Write();
  hMean->Write();
  hSigmaGaus1->Write();
  hSigmaGaus2->Write();
  hRelMagnGaus1Gaus2->Write();
  outf->Close();
}

void clean0(TH1D* h)
{
  for (int i=1;i<=h->GetNbinsX();i++)
    {
      if(h->GetBinContent(i)==0) h->SetBinError(i,1);
    }
}

TF1* fit(TString variable, TString variableplot, TTree* nt, TTree* ntMC, Double_t ptmin, Double_t ptmax, int isMC)
{
  static int count=0;
  count++;

  TCanvas* c= new TCanvas(Form("c%d",count),"",600,600);
  TH1D* h = new TH1D(Form("h-%d",count),"",nbinsmasshisto,minhisto,maxhisto);
  TH1D* hMCSignal = new TH1D(Form("hMCSignal-%d",count),"",nbinsmasshisto,minhisto,maxhisto);
  TH1D* hMCSwapped = new TH1D(Form("hMCSwapped-%d",count),"",nbinsmasshisto,minhisto,maxhisto);
  
  TF1* f = new TF1(Form("f%d",count),"[0]*([7]*([9]*Gaus(x,[1],[2])/(sqrt(2*3.14159)*[2])+(1-[9])*Gaus(x,[1],[10])/(sqrt(2*3.14159)*[10]))+(1-[7])*Gaus(x,[1],[8])/(sqrt(2*3.14159)*[8]))+[3]+[4]*x+[5]*x*x+[6]*x*x*x", 1.7, 2.0);
  TString mycut=Form("(%s&&(%s)>%f&&(%s)<%f)",seldata.Data(),variable.Data(),ptmin,variable.Data(),ptmax);
  if(isMC==1) nt->Project(Form("h-%d",count),"Dmass",TCut(weight)*TCut(mycut));   
  else nt->Project(Form("h-%d",count),"Dmass",Form("(%s&&(%s)>%f&&(%s)<%f)",seldata.Data(),variable.Data(),ptmin,variable.Data(),ptmax));   
  
  ntMC->Project(Form("hMCSignal-%d",count),"Dmass",Form("%s*(%s&&(%s)>%f&&(%s)<%f&&(Dgen==23333))",weight.Data(),selmc.Data(),variable.Data(),ptmin,variable.Data(),ptmax));   
  ntMC->Project(Form("hMCSwapped-%d",count),"Dmass",Form("%s*(%s&&(%s)>%f&&(%s)<%f&&(Dgen==23344))",weight.Data(),selmc.Data(),variable.Data(),ptmin,variable.Data(),ptmax));   
  
  /*
  TFile *fout=new TFile(Form("FitsFiles/Fits_%s_%d.root",collisionsystem.Data(),count),"recreate");
  fout->cd();
  hMCSignal->Write();
  hMCSwapped->Write();
  h->Write();  
  fout->Close();
  */
  
  f->SetParLimits(4,-1000,1000);
  f->SetParLimits(10,0.001,0.05);
  f->SetParLimits(2,0.01,0.1);
  f->SetParLimits(8,0.02,0.2);
  f->SetParLimits(7,0,1);
  f->SetParLimits(9,0,1);
  
  f->SetParameter(0,setparam0);
  f->SetParameter(1,setparam1);
  f->SetParameter(2,setparam2);
  f->SetParameter(10,setparam10);
  f->SetParameter(9,setparam9);

  f->FixParameter(8,setparam8);
  f->FixParameter(7,1);
  f->FixParameter(1,fixparam1);
  f->FixParameter(3,0);
  f->FixParameter(4,0);
  f->FixParameter(5,0);
  f->FixParameter(6,0);
  h->GetEntries();
  
  hMCSignal->Fit(Form("f%d",count),"q","",minhisto,maxhisto);
  hMCSignal->Fit(Form("f%d",count),"q","",minhisto,maxhisto);
  f->ReleaseParameter(1);
  hMCSignal->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  hMCSignal->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  hMCSignal->Fit(Form("f%d",count),"L m","",minhisto,maxhisto);
  
  f->FixParameter(1,f->GetParameter(1));
  f->FixParameter(2,f->GetParameter(2));
  f->FixParameter(10,f->GetParameter(10));
  f->FixParameter(9,f->GetParameter(9));
  f->FixParameter(7,0);
  f->ReleaseParameter(8);
  f->SetParameter(8,setparam8);
  
  hMCSwapped->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  hMCSwapped->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  hMCSwapped->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  hMCSwapped->Fit(Form("f%d",count),"L m","",minhisto,maxhisto);
  
  f->FixParameter(7,hMCSignal->Integral(0,1000)/(hMCSwapped->Integral(0,1000)+hMCSignal->Integral(0,1000)));
  f->FixParameter(8,f->GetParameter(8));
  f->ReleaseParameter(3);
  f->ReleaseParameter(4);
  f->ReleaseParameter(5);
  f->ReleaseParameter(6);

  f->SetLineColor(kRed);
  
  h->Fit(Form("f%d",count),"q","",minhisto,maxhisto);
  h->Fit(Form("f%d",count),"q","",minhisto,maxhisto);
  f->ReleaseParameter(1);
  //f->ReleaseParameter(2);                                     // you need to release these two parameters if you want to perform studies on the sigma shape
  //f->ReleaseParameter(10);                                   // you need to release these two parameters if you want to perform studies on the sigma shape
  h->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  h->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  h->Fit(Form("f%d",count),"L q","",minhisto,maxhisto);
  h->Fit(Form("f%d",count),"L m","",minhisto,maxhisto);
  
  TF1* background = new TF1(Form("background%d",count),"[0]+[1]*x+[2]*x*x+[3]*x*x*x");
  background->SetParameter(0,f->GetParameter(3));
  background->SetParameter(1,f->GetParameter(4));
  background->SetParameter(2,f->GetParameter(5));
  background->SetParameter(3,f->GetParameter(6));
  background->SetLineColor(4);
  background->SetRange(minhisto,maxhisto);
  background->SetLineStyle(2);
  
  TF1* mass = new TF1(Form("fmass%d",count),"[0]*([3]*([4]*Gaus(x,[1],[2])/(sqrt(2*3.14159)*[2])+(1-[4])*Gaus(x,[1],[5])/(sqrt(2*3.14159)*[5])))");
  mass->SetParameters(f->GetParameter(0),f->GetParameter(1),f->GetParameter(2),f->GetParameter(7),f->GetParameter(9),f->GetParameter(10));
  mass->SetParError(0,f->GetParError(0));
  mass->SetParError(1,f->GetParError(1));
  mass->SetParError(2,f->GetParError(2));
  mass->SetParError(3,f->GetParError(7));
  mass->SetParError(4,f->GetParError(9));
  mass->SetParError(5,f->GetParError(10));
  mass->SetFillColor(kOrange-3);
  mass->SetFillStyle(3002);
  mass->SetLineColor(kOrange-3);
  mass->SetLineWidth(3);
  mass->SetLineStyle(2);
  
  TF1* massSwap = new TF1(Form("fmassSwap%d",count),"[0]*(1-[2])*Gaus(x,[1],[3])/(sqrt(2*3.14159)*[3])");
  massSwap->SetParameters(f->GetParameter(0),f->GetParameter(1),f->GetParameter(7),f->GetParameter(8));
  massSwap->SetParError(0,f->GetParError(0));
  massSwap->SetParError(1,f->GetParError(1));
  massSwap->SetParError(2,f->GetParError(7));
  massSwap->SetParError(3,f->GetParError(8));
  massSwap->SetFillColor(kGreen+4);
  massSwap->SetFillStyle(3005);
  massSwap->SetLineColor(kGreen+4);
  massSwap->SetLineWidth(3);
  massSwap->SetLineStyle(1);
  
  h->SetXTitle("m_{#piK} (GeV/c^{2})");
  h->SetYTitle("Entries / (5 MeV/c^{2})");
  h->GetXaxis()->CenterTitle();
  h->GetYaxis()->CenterTitle();
  h->SetAxisRange(0,h->GetMaximum()*1.4*1.2,"Y");
  h->GetXaxis()->SetTitleOffset(1.3);
  h->GetYaxis()->SetTitleOffset(1.8);
  h->GetXaxis()->SetLabelOffset(0.007);
  h->GetYaxis()->SetLabelOffset(0.007);
  h->GetXaxis()->SetTitleSize(0.045);
  h->GetYaxis()->SetTitleSize(0.045);
  h->GetXaxis()->SetTitleFont(42);
  h->GetYaxis()->SetTitleFont(42);
  h->GetXaxis()->SetLabelFont(42);
  h->GetYaxis()->SetLabelFont(42);
  h->GetXaxis()->SetLabelSize(0.04);
  h->GetYaxis()->SetLabelSize(0.04);
  h->SetMarkerSize(0.8);
  h->SetMarkerStyle(20);
  h->SetStats(0);
  h->Draw("e");

  background->Draw("same");   
  mass->SetRange(minhisto,maxhisto);	
  mass->Draw("same");
  massSwap->SetRange(minhisto,maxhisto);
  massSwap->Draw("same");
  f->Draw("same");
  
  Double_t yield = mass->Integral(minhisto,maxhisto)/binwidthmass;
  Double_t yieldErr = mass->Integral(minhisto,maxhisto)/binwidthmass*mass->GetParError(0)/mass->GetParameter(0);
  
  std::cout<<"YIELD="<<yield<<"and error"<<yieldErr<<std::endl;
  std::cout<<"relative error="<<yieldErr/yield<<std::endl;

  TLegend* leg = new TLegend(0.65,0.58,0.82,0.88,NULL,"brNDC");
  leg->SetBorderSize(0);
  leg->SetTextSize(0.04);
  leg->SetTextFont(42);
  leg->SetFillStyle(0);
  leg->AddEntry(h,"Data","pl");
  leg->AddEntry(f,"Fit","l");
  leg->AddEntry(mass,"D^{0}+#bar{D^{#lower[0.2]{0}}} Signal","f");
  leg->AddEntry(massSwap,"K-#pi swapped","f");
  leg->AddEntry(background,"Combinatorial","l");
  leg->Draw("same");

  TLatex Tl;
  Tl.SetNDC();
  Tl.SetTextAlign(12);
  Tl.SetTextSize(0.04);
  Tl.SetTextFont(42);
  Tl.DrawLatex(0.18,0.93, "#scale[1.25]{CMS} Preliminary");
  Tl.DrawLatex(0.65,0.93, Form("%s #sqrt{s_{NN}} = 5.02 TeV",collisionsystem.Data()));

  TLatex* tex;

  tex = new TLatex(0.22,0.78,Form("%.3f < %s  < %.3f",ptmin,variableplot.Data(),ptmax));
  tex->SetNDC();
  tex->SetTextFont(42);
  tex->SetTextSize(0.04);
  tex->SetLineWidth(2);
  tex->Draw();

  tex = new TLatex(0.22,0.83,"|y| < 1.0");
  tex->SetNDC();
  tex->SetTextFont(42);
  tex->SetTextSize(0.04);
  tex->SetLineWidth(2);
  tex->Draw();

  h->GetFunction(Form("f%d",count))->Delete();
  TH1F* histo_copy_nofitfun = ( TH1F * ) h->Clone("histo_copy_nofitfun");
  histo_copy_nofitfun->Draw("esame");
//
  if(nBins==1) c->SaveAs(Form("FitsVariables/DMass-inclusive%s_%d.pdf",collisionsystem.Data(),count));
  else c->SaveAs(Form("FitsVariables/DMass%s_%d.pdf",collisionsystem.Data(),count));
  
  return mass;
}


int main(int argc, char *argv[])
{
  if((argc != 14))
  {
    std::cout << "Wrong number of inputs" << std::endl;
    return 1;
  }
  
  if(argc == 14)
    fitDVariable(argv[1],argv[2],argv[3],argv[4], argv[5], argv[6], argv[7], atoi(argv[8]), atof(argv[9]), atoi(argv[10]),argv[11],argv[12],argv[13]);
  return 0;
}

