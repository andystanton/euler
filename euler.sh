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

script_name=$(basename ${0}); pushd $(dirname ${0}) > /dev/null
script_path=$(pwd -P); popd > /dev/null

valid_extensions=('java' 'scala' 'rb' 'py' 'rs' 'go' 'cpp' 'js' 'coffee' 'groovy' 'c' 'd' 'hs' 'erl')

exercise_number=${1}
if [[ ${2} == "debug" ]]; then
    run_debug=true
fi
exercise_path=${script_path}/${exercise_number}
answer=$(cat 2> /dev/null ${exercise_path}/answer)

function run_concatenate_list() {
    local separator=${1}; shift; local source_list=(${@}); local temp_ifs=${IFS}
    IFS=${separator}; local concatenated="${source_list[*]}"; IFS=${temp_ifs}
    echo ${concatenated}
}

function run_validate() {
    if [[ -z ${exercise_number} ]]; then
        local msg_1=" ${text_bold}Usage:"
        local msg_2=" ${text_reset}./${script_name}"
        local msg_3=" ${text_lightblue}<exercise number>"
        local msg_4=" ${text_reset}"

        echo " ${msg_1}${msg_2}${msg_3}${msg_4}"
        exit 1
    fi

    if [[ ! -d ${exercise_path} ]]; then
        echo "${text_red}Error${text_reset} No such folder ${exercise_path}"
        exit 1
    fi
}

function run_strip_extension() {
    echo ${1} | sed -E "s/\.[[:alnum:]]*$//";
}

function run_append_extension() {
    echo "${1}.${2}"
}

function run_get_extension() {
    echo ${1} | sed -En 's/^.*\.(.*)$/\1/p'
}

function run_execute_c_family() {
    local extension=${2}
    local compiler=${3}
    local args=${4}

    local srcfile=${1}
    local binfile=$(run_strip_extension ${srcfile})

    ${compiler} ${args} ${srcfile} -o ${binfile} && ./${binfile}
}

function run_execute_java() {
    local srcfile=${1}
    local binfile=$(run_strip_extension ${1})
    javac ${srcfile} && java ${binfile}
}

function run_execute_script_family() {
    local srcfile=${1}
    local runtime=${2}
    ${runtime} ${srcfile}
}

function run_execute_docker() {
    local docker_image=${1}
    local srcfile=${2}
    local result=$(docker run -t --rm -v $(pwd -P):/data/euler ${1} /data/euler/${2})

    # in case of carriage return at end of result
    echo ${result} | perl -p -i -e 's/\r\n$/\n/g'
}

function run_execute_code() {
    local code_dir=${1}

    local extension_string=$(run_concatenate_list '|' ${valid_extensions[@]})
    local found_files=$(find -E ${code_dir} -regex ".*\.(${extension_string})")

    local run_count=0
    local run_success=0

    for found_file in ${found_files}; do
        run_count=$((run_count + 1))

        local file_extension=$(run_get_extension ${found_file})
        local base_file_name=$(basename ${found_file})
        local base_dir_name=$(dirname ${found_file})

        echo
        echo "Solution: ${text_bold}${found_file}${text_reset}"

        if [[ ${run_debug} == true ]]; then
            echo "Source Details:"
            echo " - ${text_lightblue}path${text_reset}: ${text_bold}${base_dir_name}${text_reset}"
            echo " - ${text_lightblue}name${text_reset}: ${text_bold}${base_file_name}${text_reset}"
            echo " - ${text_lightblue}extension${text_reset}: ${text_bold}${file_extension}${text_reset}"
        fi

        cd ${base_dir_name}

        case ${file_extension} in
            java)
                local result=$(run_execute_java ${base_file_name})
                ;;
            rs)
                local result=$(run_execute_c_family ${base_file_name} ${file_extension} rustc)
                ;;
            c)
                local result=$(run_execute_c_family ${base_file_name} ${file_extension} gcc)
                ;;
            d)
                local result=$(run_execute_script_family ${base_file_name} rdmd)
                ;;
            cpp)
                local result=$(run_execute_c_family ${base_file_name} ${file_extension} c++ -std=c++11)
                ;;
            hs)
                local result=$(run_execute_c_family ${base_file_name} ${file_extension} ghc -v0)
                ;;
            rb)
                local result=$(run_execute_script_family ${base_file_name} ruby)
                ;;
            py)
                local result=$(run_execute_script_family ${base_file_name} python)
                ;;
            scala)
                local result=$(run_execute_docker andystanton/scala ${base_file_name})
                ;;
            go)
                local result=$(run_execute_script_family ${base_file_name} "go run")
                ;;
            js)
                local result=$(run_execute_script_family ${base_file_name} node)
                ;;
            coffee)
                local result=$(run_execute_script_family ${base_file_name} coffee)
                ;;
            groovy)
                local result=$(run_execute_script_family ${base_file_name} groovy)
                ;;
            erl)
                erl -compile $(run_strip_extension ${base_file_name})
	            local result=$(erl -noshell -s $(run_strip_extension ${base_file_name}) main -s init stop)
                ;;
            *)
                echo -n "Unknown file type"
                exit 1
            ;;
        esac

        if [[ -n ${answer} ]]; then
            if [[ ${answer} == ${result} ]]; then
                local result_text=${text_green}${result}${text_reset}
                run_success=$((run_success + 1))
            else
                local result_text=${text_red}${result}${text_reset}
            fi
        else
            local result_text=${result}
        fi

        echo "Result: ${result_text}"
    done

    echo
    if [[ -n ${answer} ]]; then
        if [[ ${run_success} == ${run_count} ]]; then
            echo "${text_green}Success!${text_reset} ${text_bold}${run_success}/${run_count}${text_reset}"
        else
            echo "${text_red}Failure!${text_reset} ${text_bold}${run_success}/${run_count}${text_reset}"
        fi
    else
        echo "Ran ${run_count}"
    fi


}

run_validate

echo
echo "${text_lightblue}Project Euler${text_reset} ${text_bold}problem ${exercise_number}${text_reset}"
echo

if [[ -f ${exercise_path}/problem ]]; then
    cat ${exercise_path}/problem | fold -w 80 -s
fi

if [[ -n ${answer} ]]; then
    echo
    echo "${text_bold}The expected result is:${text_reset}"
    for line in ${answer}; do
        echo " - ${text_lightblue}${line}${text_reset}"
    done;
fi

run_execute_code ${exercise_path}
