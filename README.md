# Neuro MATLAB Git Demo

這是一個示範專案，用來展示如何在神經科學資料分析中，使用  
MATLAB Project 搭配 Git / GitHub 來管理程式碼與版本。

---

## 專案結構
neuro-matlab-git-demo/  
├─ preprocess/  
│ ├─ preprocess_lfp.m % 共用 LFP 前處理流程  
│ └─ bandpass_filter.m % 基本 bandpass filter  
│  
├─ analysis/  
│ ├─ alex/  
│ │ └─ demo_decoding.m % 個人分析示範（branch 使用）  
│ └─ template/  
│ └─ analysis_template.m % 分析腳本範本  
│  
├─ utils/  
│ ├─ plot_helper.m % 簡易繪圖工具  
│ └─ load_config.m % 讀取本機設定檔  
│  
├─ config/  
│ ├─ config_template.m % 設定範例（會上 GitHub）  
│ └─ config_local.m % 個人本機設定（不上 GitHub）  
│  
├─ data/ % 本機資料（gitignore）  
│ └─ sample_lfp.mat  
│  
├─ figures/ % 分析輸出圖表  
│  
