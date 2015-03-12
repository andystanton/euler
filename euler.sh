#/bin/bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

text_red=$(tput setaf 1)
text_green=$(tput setaf 2)
text_lightblue=$(tput setaf 4)
text_reset=$(tput sgr0)
text_bold=$(tput bold)

valid_extensions=(
    'c'
    'clj'
    'coffee'
    'cpp'
    'cs'
    'd'
    'erl'
    'fs'
    'go'
    'groovy'
    'hs'
    'java'
    'js'
    'lisp'
    'm'
    'ml'
    'pl'
    'php'
    'py'
    'rb'
    'rs'
    'scala'
    'sh'
)

script_name=$(basename ${0}); pushd $(dirname ${0}) > /dev/null
script_path=$(pwd -P); popd > /dev/null

exercise_number=$((10#${1}))
exercise_number_padded=$(printf "%03d" ${exercise_number})
target_language=${2}
exercise_path=${script_path}/problems/${exercise_number_padded}
answer=$(cat 2> /dev/null ${exercise_path}/answer)

function euler_concatenate_list() {

    local separator=${1}; shift; local source_list=(${@}); local temp_ifs=${IFS}
    IFS=${separator}; local concatenated="${source_list[*]}"; IFS=${temp_ifs}
    echo -e ${concatenated}

}

function euler_validate() {

    if [[ -z ${exercise_number} ]]; then

        echo -e " ${text_bold}Usage: ${text_reset}./${script_name} ${text_lightblue}<exercise number>${text_reset}"
        exit 1

    fi

    if [[ ! -d ${exercise_path} ]]; then

        echo -e "${text_red}Error${text_reset} No such folder ${exercise_path}"
        exit 1

    fi
}

function euler_welcome() {

    echo -en "\n${text_lightblue}Project Euler${text_reset} "
    echo -e  "${text_bold}problem ${exercise_number}${text_reset}\n"

    if [[ -f ${exercise_path}/problem ]]; then
        cat ${exercise_path}/problem | fold -w 80 -s
    fi

    if [[ -n ${answer} ]]; then
        echo -e "\n${text_bold}The expected result is:${text_reset}"
        for line in ${answer}; do
            echo -e " - ${text_lightblue}${line}${text_reset}"
        done;
    fi
}

function euler_execute_docker() {

    local image=${1}
    local srcfile=${2}
    local entrypoint_args=${3}
    local workdir=/data/euler
    local result=$(docker run -t --rm \
                    -w ${workdir} \
                    -v $(pwd -P)/${srcfile}:${workdir}/${srcfile} \
                    ${image} ${srcfile} ${entrypoint_args})

    # in case of carriage return at end of result
    echo -e ${result} | perl -p -e 's/\r\n$/\n/g'

}

function euler_execute() {
    local start_time=$(date +%s)

    local code_dir=${1}

    local extension_string=$(euler_concatenate_list '|' ${valid_extensions[@]})
    local found_files=$(find -E ${code_dir} -regex ".*\.(${extension_string})")

    local euler_count=0
    local euler_success=0

    for found_file in ${found_files}; do

        local file_extension=$(echo -e ${found_file} | sed -En 's/^.*\.(.*)$/\1/p')

        if [[ -z ${target_language} || ${target_language} == ${file_extension} ]]; then

            euler_count=$((euler_count + 1))

            local base_filename=$(basename ${found_file})
            local base_dirname=$(dirname ${found_file})

            echo -e "\nSolution: ${text_bold}${found_file}${text_reset}"

            cd ${base_dirname}

            case ${file_extension} in

                c)      local result=$(euler_execute_docker reentry/exec-cpp        ${base_filename}) ;;
                clj)    local result=$(euler_execute_docker reentry/exec-clojure    ${base_filename}) ;;
                coffee) local result=$(euler_execute_docker reentry/exec-coffee     ${base_filename}) ;;
                cpp)    local result=$(euler_execute_docker reentry/exec-cpp        ${base_filename} -std=c++14) ;;
                cs)     local result=$(euler_execute_docker reentry/exec-mono       ${base_filename} c#) ;;
                d)      local result=$(euler_execute_docker reentry/exec-d          ${base_filename}) ;;
                erl)    local result=$(euler_execute_docker reentry/exec-erlang     ${base_filename} main) ;;
                fs)     local result=$(euler_execute_docker reentry/exec-mono       ${base_filename} f#) ;;
                go)     local result=$(euler_execute_docker reentry/exec-go         ${base_filename}) ;;
                groovy) local result=$(euler_execute_docker reentry/exec-groovy     ${base_filename}) ;;
                hs)     local result=$(euler_execute_docker reentry/exec-haskell    ${base_filename} -v0) ;;
                java)   local result=$(euler_execute_docker reentry/exec-java       ${base_filename}) ;;
                js)     local result=$(euler_execute_docker reentry/exec-node       ${base_filename}) ;;
                lisp)   local result=$(euler_execute_docker reentry/exec-lisp       ${base_filename}) ;;
                m)      local result=$(euler_execute_docker reentry/exec-objc       ${base_filename} -std=c99) ;;
                ml)     local result=$(euler_execute_docker reentry/exec-ocaml      ${base_filename}) ;;
                pl)     local result=$(euler_execute_docker reentry/exec-perl       ${base_filename}) ;;
                php)    local result=$(euler_execute_docker reentry/exec-php        ${base_filename}) ;;
                py)     local result=$(euler_execute_docker reentry/exec-python     ${base_filename}) ;;
                rb)     local result=$(euler_execute_docker reentry/exec-ruby       ${base_filename}) ;;
                rs)     local result=$(euler_execute_docker reentry/exec-rust       ${base_filename}) ;;
                scala)  local result=$(euler_execute_docker reentry/exec-scala      ${base_filename}) ;;
                sh)     local result=$(euler_execute_docker reentry/exec-bash       ${base_filename}) ;;
                *)      echo -e -n "Unknown file type"; exit 1 ;;

            esac

            if [[ -n ${answer} ]]; then

                if [[ ${answer} == ${result} ]]; then
                    local result_text=${text_green}${result}${text_reset}
                    euler_success=$((euler_success + 1))
                else
                    local result_text=${text_red}${result}${text_reset}
                fi

            else
                local result_text=${result}
            fi

            echo -e "Result: ${result_text}"
        fi
    done

    local end_time=$(date +%s)
    local run_time=$(echo "${end_time} - ${start_time}" | bc)

    if [[ -n ${answer} && ${euler_count} > 0 ]]; then

        if [[ ${euler_success} == ${euler_count} ]]; then
            echo -en "\n${text_green}Success!${text_reset} "
            echo -e  "${text_bold}${euler_success}/${euler_count} Passed in ${run_time}s${text_reset}"
            exit 0
        else
            echo -en "\n${text_red}Failure!${text_reset} "
            echo -e  "${text_bold}${euler_success}/${euler_count} Passed in ${run_time}s${text_reset}"
            exit 1
        fi

    else
        echo -e "\nRan ${euler_count} in ${run_time}s"
        exit 0
    fi

}

euler_validate

euler_welcome

euler_execute ${exercise_path}
