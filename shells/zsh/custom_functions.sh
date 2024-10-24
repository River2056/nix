function kills() {
    tmux kill-server
}

function ct() {
    cur="$(date +"%Y/%m/%d")"
    template="
/*
 * ===========================================================================
 * 
 * IBM Confidential
 * 
 * AIS Source Materials
 * 
 * (C) Copyright IBM Corp. 2024.
 * 
 * ===========================================================================
 */


//@formatter:off
/**
* @(#).java
* 
* <p>Description:</p>
* 
* <p>Modify History:</p>
* v1.0, $cur, Kevin Tung
* <ol>
*  <li>初版</li>
* </ol>
*/
//@formatter:on"
    echo $template
    echo $template | pbcopy
}

function build() {
    ./gradlew clean build < /dev/null &
    echo $!
    echo $?
}

function cb-all() {
    cd ~/code/aibank-ms/business-services/service-aibank-system-config && echo "service-system-config" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-security && echo "service-security" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-information && echo "service-information" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-user && echo "service-user" && make clean

    cd ~/code/aibank-ms/business-services/service-aibank-account && echo "service-account" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-credit-card && echo "service-credit-card" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-deposit && echo "service-deposit" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-foreign-exchange && echo "service-foreign-exchange" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-insurance && echo "service-insurance" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-invest && echo "service-invest" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-loan && echo "service-loan" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-mutual-fund && echo "service-mutual-fund" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-notification && echo "service-notification" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-payment && echo "service-payment" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-preferences && echo "service-preference" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-push-listener && echo "service-push-listener" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-push-sender && echo "service-push-sender" && make clean
    cd ~/code/aibank-ms/business-services/service-aibank-transfer && echo "service-transfer" && make clean

    cd ~/code/aibank-ms/channel-services/channel-aibank-system && echo "channel-system" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-general && echo "channel-general" && make clean

    cd ~/code/aibank-ms/channel-services/channel-aibank-creditcard && echo "channel-credit-card" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-creditcardactivities && echo "channel-creditcardactivities" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-deposit && echo "channel-deposit" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-fund && echo "channel-fund" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-invest && echo "channel-invest" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-loan && echo "channel-loan" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-overview && echo "channel-overview" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-payment && echo "channel-payment" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-point && echo "channel-point" && make clean
    cd ~/code/aibank-ms/channel-services/channel-aibank-preferences && echo "channel-preferences" && make clean
}

function killapp() {
    tmux kill-session -t app
}

function killp() {
    ps aux | fzf --multi | awk '{print $2}' | xargs -I {} kill -9 {}
}

function docs() {
    find ~/docs -iname "*$1*" | fzf | xargs -I {} open {}
}

function eai() {
    original_path=$(pwd)
    cd /Users/kevintung/code/aibank-ms/tfb-nano-message-schema && ./eai_build.sh
    cd $original_path
}

function runapp() {
    ls ~/code/aibank-ms/business-services ~/code/aibank-ms/channel-services | sed 's/\/Users.*//g' | fzf -m | frapp -r
}

function hc() {
    ls ~/code/aibank-ms/business-services ~/code/aibank-ms/channel-services | sed 's/\/Users.*//g' | fzf -m | frapp
}

function cleard() {
    rm /Users/kevintung/Desktop/*
}

function rmaibank() {
    rm -rf /Users/kevintung/.local/share/nvim/mason/packages/workspace/Users/kevintung/code/aibank-ms
}

function enc() {
    res=$(aestool -v $1)
    echo $res
    echo $res | pbcopy
}

function dec() {
    res=$(aestool -m dec -v $1)
    echo $res
    echo $res | pbcopy
}
