#!/bin/bash

echo "======================================"
echo "    Welcome to Cloud Cleaner Bot      "
echo "======================================"

# Function to check and delete stopped EC2 instances
check_stopped_ec2() {
  echo ""
  echo " Fetching stopped EC2 instances..."
  stopped_instances=$(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=stopped" \
    --query "Reservations[*].Instances[*].InstanceId" \
    --output text)

  if [ "$stopped_instances" != "" ]; then
    echo " Stopped Instances Found:"
    echo "$stopped_instances"

    echo -n " Do you want to delete all stopped instances? (y/n): "
    read delete_instances

    if [ "$delete_instances" == "y" ]; then
      # Showing user what will be deleted
      echo "These stopped instances will be terminated: $stopped_instances"
      for instance_id in $stopped_instances; do
        echo "Terminating instance: $instance_id"
        aws ec2 terminate-instances --instance-ids "$instance_id" 
      done
  echo " All stopped instances deleted!"
    else
      echo "   These instances may cost you money!"
    fi
  else
    echo " No stopped EC2 instances found."
  fi
}

# Function to check and delete unused EBS volumes
check_unattached_ebs() {
  echo ""
  echo " Checking unused EBS volumes...."
  unused_volumes=$(aws ec2 describe-volumes \
    --filters Name=status,Values=available \
    --query "Volumes[*].VolumeId" \
    --output text)

  if [ "$unused_volumes" != "" ]; then
    echo " Unused Volumes Found:"
    echo "$unused_volumes"

    echo -n "Do you want to delete unused volumes? (y/n): "
    read delete_volumes

    if [ "$delete_volumes" == "y" ]; then
      for volume_id in $unused_volumes; do
        echo " Deleting volume: $volume_id"
        aws ec2 delete-volume --volume-id "$volume_id"
 done
      echo "All unused volumes deleted!"
    else
      echo "   These volumes may cost you money!"
    fi
  else
    echo "No unused EBS volumes found."
  fi
}

# Function to check and release unused Elastic IPs
check_unused_eips() {
  echo ""
  echo " Checking unused Elastic IPs..."
  unused_eips=$(aws ec2 describe-addresses \
    --query "Addresses[?AssociationId==null].AllocationId" \
    --output text)

  if [ "$unused_eips" != "" ]; then
    echo " Unused Elastic IPs Found:"
    echo "$unused_eips"

    echo -n " Do you want to release unused EIPs? (y/n): "
    read release_eips

    if [ "$release_eips" == "y" ]; then
      for eip_id in $unused_eips; do
        echo " Releasing EIP: $eip_id"
        aws ec2 release-address --allocation-id "$eip_id" 
   done
      echo " All unused EIPs released!"
    else
      echo "   These EIPs may incur charges!"
    fi
  else
    echo " No unused Elastic IPs found."
  fi
}

# Function to check and delete old EBS snapshots
check_unused_snapshots() {
  echo ""
  echo " Checking available EBS snapshots..."
  snapshots=$(aws ec2 describe-snapshots \
    --owner-ids self \
    --query "Snapshots[*].SnapshotId" \
    --output text)

  if [ "$snapshots" != "" ]; then
    echo " Snapshots Found:"
    echo "$snapshots"

    echo -n " Do you want to delete all these snapshots? (y/n): "
    read delete_snapshots

    if [ "$delete_snapshots" == "y" ]; then
      for snapshot_id in $snapshots; do
        echo " Deleting snapshot: $snapshot_id"
        aws ec2 delete-snapshot --snapshot-id "$snapshot_id"
      done
      echo " All snapshots deleted!"
    else
      echo "   These snapshots may incur storage costs!"
    fi
  else
    echo " No snapshots found."
  fi
}

# Calling the functions
check_stopped_ec2
check_unattached_ebs
check_unused_eips
check_unused_snapshots

echo ""
echo " Cleanup complete. Your AWS account is now cleaner!"
