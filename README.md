## Title
Estimating user’s emotion from non-verbal behaviour in communication

（実際に作成した論文は[こちら](https://github.com/kurokawa5/msc_project_for_job_applicaion/blob/main/MSc_project_2548269m.pdf)）

<img src="https://user-images.githubusercontent.com/76276773/208693371-e3718fff-0fb2-48af-b908-ce9af16fadcc.jpeg" width="600">

## Grade
Distinction

## Abstract
コンピュータが人間の感情などの非言語コミュニケーションを感知し、会話戦略を修正することで、人間とコンピュータのインタラクションはより自然なものになると考えられる。本論文では、知的エージェントによるアプリケーションユーザーを支援するために、マルチモーダルな特徴量からコミュニケーションにおけるユーザーの感情を推定するモデルの開発に焦点を当てる。この目的のために、14本のビデオでプレゼンテーションや会話を観察した参加者の顔、目、口、姿勢の特徴を含むマルチモーダルデータセットを使用する。また、このデータセットには、各参加者の発言内容の英語字幕が含まれており、事前に学習したBERTモデルを用いて感情分析を行い、ユーザの感情カテゴリを予め用意します。顔、目、口、姿勢の動きなど様々な特徴量を抽出し、ユーザーの感情カテゴリを推定しました。これらの特徴量から、Pytorchの3層ニューラルネットワークとランダムフォレストを用いて、EkmanレベルとGroupレベルの感情カテゴリを推定するクラス分類モデルを作成し、感情カテゴリの推定精度を評価した。実験の結果、マルチモーダルモデルは、Ekmanレベルで0.82、Groupレベルで0.96の分類精度を達成しました。今回使用したデータセットでは、非言語情報の量が限られているにもかかわらず、このモデルはユーザーの感情を予測する優れた可能性を持っていると考えています。さらに、ユーザーが話している動画から非言語データを収集し、感情推定モデルを作成することができました。他の動画についても同様の手法で、ユーザの顔、手、口、姿勢などの非言語情報を得ることができ、今後のプロジェクトで活用することができます。

## Overall Objectives
今回は下記の３つのモデルを作成しました。
1. 顔、口、目のランドマークに関する特徴量から、フレームごとの感情カテゴリを予測するモデル
2. 姿勢に関連する特徴量からフレームごとの感情カテゴリを予測するモデル
3. 顔、口、目、姿勢に関する特徴量からフレームごとの感情カテゴリを予測するモデル(1+2)

## Related Technologies
1. BERT
2. OpenFace
3. OpenPose

<img src="https://user-images.githubusercontent.com/76276773/208697300-cbbf41e3-b888-4a2a-a2b2-8ad03d003b5a.png" width="500"> <img src="https://user-images.githubusercontent.com/76276773/208697315-be296f80-0373-42e4-8a9f-4d6b72e1decb.png" width="500">

## Research Steps

<img src="https://user-images.githubusercontent.com/76276773/208707374-2f369c1b-580f-4996-9d6d-2499299f71ba.png" width="700">

以下、編集中

## Data Preparation

### データ収集
このプロジェクトでは、平均13分59秒の動画を14本収集しました。
話者による発話数は1動画あたり平均269回であり、合計3761回でした。　
つまり3761個の感情カテゴリーを得ることができました。

英語字幕のタイムスタンプから、各センテンスの終了時刻とそのセンテンス中の間隔（終了時刻-開始時刻）を求めます。

各文章の動画に対してOpenFaceとOpenPoseの特徴抽出を行うために、FFm-pegという動画や音声を録画・変換・再生するフリーソフトを使って各文章のYouTube動画を切り出す。

各文章のタイムスタンプと発話中の間隔から、各文章の動画を抽出し、(a) OpenFace入力または手動データ観測用のMP4、(b) OpenPose入力用のAVIファイルフォーマットで出力する。


### Sentiment Analysisの実施
学習・評価データの目的変数として用いる感情カテゴリを用意するため、英語字幕の1文に対して感情分析を行いました。
その感情分析には、感情カテゴリをエクマンレベル(joy, anger, fear, sadness, disgust, and surprise)+ neutral とグループレベル(positive, negative, ambiguous) + neutralで分類したBERTベースの事前学習済みモデルを使用しました。

※neutralは、感情カテゴリに分類できないような中立的なもの（迷ったらneutral行き）
※ambiguousは「驚き」みたいなネガティブよりもポジティブに近いもの


<img src="https://user-images.githubusercontent.com/76276773/208846072-7c41dfc7-d613-469d-a32f-9b8ded8ccffa.png" width="600"> 

<img src="https://user-images.githubusercontent.com/76276773/208846533-7814be10-768d-45c3-9c00-071bccd075ea.png" width="600"> 

<img src="https://user-images.githubusercontent.com/76276773/208846640-8917f0e1-0669-43fb-a338-69c403d59766.png" width="600"> 

### Extracting the Facial Feature Points

Output Format
https://github.com/TadasBaltrusaitis/OpenFace/wiki/Output-Format

### Extracting the Body Pose Feature Points

OpenPose Doc - Output
https://cmu-perceptual-computing-lab.github.io/openpose/web/html/doc/md_doc_02_output.html

## Implementation

### Implementation of Classification Models

ユーザーの感情カテゴリーの7クラス分類と4クラス分類のモデルを作成する。

比較的にスコア（Accuracy）が良かったロジスティック回帰、ランダムフォレスト、3層ニューラルネットワークを代表として採用しました。

SVMなども使用して分類してみましたが、スコアがそこまで伸びなかったです。

## Script
使用したスクリプトの格納先は以下となります。

https://github.com/kurokawa5/msc_project_for_job_applicaion/tree/main/python

https://github.com/kurokawa5/msc_project_for_job_applicaion/tree/main/sh

|  Script名  |  役割  |
| ---- | ---- |
|  01_youtube_downloader.ipynb  | ライブラリ（pytube）を使って指定されたYoutube動画を取得する |
|  02_organized_excel_file.ipynb  | 開始時刻と字幕文章が交互に並んで1列になっているものを、それぞれの列を用意し、整理する |
|  03_adding_time_information.ipynb  |  字幕文章の終了時刻とその差分 （終了時刻 - 開始時刻）を算出する |
|  04_emotion_extraction_from_subtitles.ipynb  |  事前に学習したBERTモデル(GoEmotions PyTorch)を用いて、すべての文に感情を付与する |
|  05_ffmpeg.ipynb  |  再生時間や差分に応じて動画（mp4、avi）を感情カテゴリー毎に切り出す  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |
|  TD  |  TD  |

## 補足

### Schedule
約2.5ヶ月使用してアイデア決めから修論作成まで実施しました。
実際のスケジュール感は以下の図のようなイメージです。

モデル作成

<img src="https://user-images.githubusercontent.com/76276773/208737538-dec6ec57-273a-4a26-a20a-c6cc6d0c0e8e.png" width="800"> 

修論作成

<img src="https://user-images.githubusercontent.com/76276773/208737560-6d4cecc9-53b1-4237-9e32-cc0be68c4835.png" width="800">

### Meeting materials
毎週、教授とミーティング(30分〜1時間)を行い、進捗報告をしました。
その時に使用した資料を[こちら](https://github.com/kurokawa5/msc_project_for_job_applicaion/tree/main/meeting)に格納してます。
