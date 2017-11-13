echo "Upload new network config";
echo "=====================================";
host='quorumnx'$1'.southeastasia.cloudapp.azure.com';
scp networkNodesInfo.json azureuser@$host:/home/azureuser/quorum-netting-multi
echo "Completed";
