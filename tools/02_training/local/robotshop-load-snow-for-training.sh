#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# LOAD LOGS DIRECTLY INTO ELASTICSEARCH
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ADAPT VALUES
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


export APP_NAME=robot-shop
export INDEX_TYPE=changerisk
export TRAINING_DATA_URL=https://github.com/niklaushirt/cp4waiops-trainingdata.git


if [[  $WAIOPS_NAMESPACE =~ "" ]]; then
    # Get Namespace from Cluster 
    echo "   ------------------------------------------------------------------------------------------------------------------------------"
    echo "   🔬 Getting Installation Namespace"
    echo "   ------------------------------------------------------------------------------------------------------------------------------"
    export WAIOPS_NAMESPACE=$(oc get po -A|grep aiops-orchestrator-controller |awk '{print$1}')
    echo "       ✅ OK - AI Manager:    $WAIOPS_NAMESPACE"
fi



#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT EDIT BELOW
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo "   ------------------------------------------------------------------------------------------------------------------------------"
echo "   🌏 Getting Training Data from $TRAINING_DATA_URL"
echo "   ------------------------------------------------------------------------------------------------------------------------------"
rm -r -f ./tools/02_training/TRAINING_FILES
git clone $TRAINING_DATA_URL ./tools/02_training/TRAINING_FILES/ELASTIC/

echo ""
./tools/02_training/scripts/load-es-index.sh

rm -r -f ./tools/02_training/TRAINING_FILES

