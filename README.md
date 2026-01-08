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
├─ README.md  
├─ .gitignore  
└─ neuro_demo.prj % MATLAB Project 檔案  
  
---  

## 資料夾說明

### preprocess/
共用的資料前處理程式。  
提供穩定、可重現的處理流程，會影響所有後續分析，修改需謹慎。

### analysis/
個人或實驗專屬的分析程式。  
每個人使用自己的子資料夾，可自由嘗試不同分析方法，不影響他人流程。

### utils/
共用的小工具與輔助函式。  
例如繪圖、工具函式、設定讀取等。

### config/
本機環境設定檔。  
- `config_template.m`：設定範例（會上 GitHub）  
- `config_local.m`：個人電腦設定（不上 GitHub）

### data/
資料存放位置。  
包含原始或處理後資料，不納入 Git 版本控制。

### figures/
分析產生的圖表輸出資料夾。

---

## 其他檔案

### neuro_demo.prj
MATLAB Project 檔案，用來管理專案路徑與 Git 整合，建議從此檔案開啟專案。

### .gitignore
定義不需納入 Git 管理的檔案，例如資料與個人設定。

