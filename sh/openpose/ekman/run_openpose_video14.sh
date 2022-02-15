videodir="video14"
for dir in /content/drive/MyDrive/05_workspace/01_msc_project/data/output/05_cutting_out_videos/ekman/$videodir/*
do
    dirname=`basename $dir`
    #echo $dir
    mkdir -p /content/drive/MyDrive/05_workspace/01_msc_project/data/output/09_openpose/ekman/$videodir/$dirname
    for file in /content/drive/MyDrive/05_workspace/01_msc_project/data/output/05_cutting_out_videos/ekman/$videodir/$dirname/*.avi
    do
        filename=`basename $file .avi`
        echo $filename
        #inputvideo=/content/drive/MyDrive/midori/output/04_cutting_out_videos/video02/$dirname/$filename.avi
        #echo $inputvideo
        outputjson=/content/drive/MyDrive/05_workspace/01_msc_project/data/output/09_openpose/ekman/$videodir/$dirname/$filename/json
        echo $outputjson
        mkdir -p $outputjson
        outputavi=/content/drive/MyDrive/05_workspace/01_msc_project/data/output/09_openpose/ekman/$videodir/$dirname/$filename.avi
        /content/openpose/build/examples/openpose/openpose.bin --video $file --display 0 --write_video $outputavi --write_json  $outputjson --hand --face
        # convert the result into MP4
        
        #echo $filename
        outputmp4=/content/drive/MyDrive/05_workspace/01_msc_project/data/output/09_openpose/ekman/$videodir/$dirname/$filename.mp4
        ffmpeg -y -loglevel info -i $outputavi $outputmp4
    done
done
