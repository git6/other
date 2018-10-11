# Camera_RAW-JPG.command
echo ${0##*/} "is Running..."
# SETUP
cd `dirname $0`
JPG_EXT='JPG' #JPGの拡張子
RAW_EXT='ARW' #RAWの拡張子/α→ARW

DEFAULT_FROM_DIR='./'

# INIT
for OPT in "$@"
do
    case $OPT in
            '-date' )
            FLAG_DATE=1
            VALUE_DATE=$2
            ;;
        '-dir' )
            FLAG_DIR=1
            VALUE_DIR=$2
            #shift 2
            ;;
    esac
    shift
done

if [ "$FLAG_DIR" ]; then
    FROM_DIR=$VALUE_DIR
else
    if [ "$DEFAULT_FROM_DIR" ]; then
        FROM_DIR=$DEFAULT_FROM_DIR
    else
        echo "[-dir 画像元ディレクトリの指定] が必要です"
        exit
    fi
fi


## カウント
JPG_COUNT=0;RAW_COUNT=0
for jpg in $( ls $FROM_DIR | grep .$JPG_EXT$ ); do   
    $((++JPG_COUNT)) 2>/dev/null
done
for raw in $( ls $FROM_DIR | grep .$RAW_EXT$ ); do   
    $((++RAW_COUNT)) 2>/dev/null
done


echo "【実行内容確認】"
echo "DATE : $DATE"
echo "FROM_DIR : $FROM_DIR"
echo "JPG : $JPG_COUNT 件"
echo "RAW : $RAW_COUNT 件"

#find ./* -maxdepth 0 -newermt '20150806 10:59' ! -newermt '20180416 14:00'

## ディレクトリの存在確認
if [ -d $FROM_DIR/$JPG_EXT ]; then
echo "JPG ディレクトリが既に存在するためキャンセルしました"
exit
fi
if [ -d $FROM_DIR/$RAW_EXT ]; then
echo "RAW ディレクトリが既に存在するためキャンセルしました"
exit
fi

## EXECUTE CONFIRM

echo "移動を実施しますか？ : y"
read CONFIRM

if [ $CONFIRM = y ]; then
  echo ""
else
  echo "キャンセルしました"
  exit
fi

## MKDIR
mkdir -p $FROM_DIR/$JPG_EXT 2>/dev/null
mkdir -p $FROM_DIR/$RAW_EXT 2>/dev/null


## 実行
for jpg in $( ls $FROM_DIR | grep .$JPG_EXT$ ); do   
    echo "move > "${jpg} 
    mv -f $FROM_DIR/${jpg} $FROM_DIR/$JPG_EXT
done
for raw in $( ls $FROM_DIR | grep .$RAW_EXT$ ); do   
    echo "move > "${raw} 
    mv -f $FROM_DIR/${raw} $FROM_DIR/$RAW_EXT
done

echo "後処理を実行しますか？: y"
read CONFIRM

if [ $CONFIRM = y ]; then
  mkdir -p $FROM_DIR/OUT 2>/dev/null
  echo "OUTフォルダを作成しました。"
  rm ${0##*/}
  echo ${0##*/} "を削除しました。"
else
  echo "キャンセルしました"
  exit
fi

echo "Done."