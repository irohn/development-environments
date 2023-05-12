
function deployment() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -n|--name)
            kubectl get deployment -A -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}' | grep -m 1 $2
            shift
            shift
            return
            ;;
            -s|--namespace)
            kubectl get deployment -A -o=jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}' | grep -m 1 $2 | awk '{print $1}'
            shift
            shift
            return
            ;;
            -*|--*)
            echo "Unknown option $1"
            return 1
            ;;
            *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift
            ;;
        esac
    done
}

function pod() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -n|--name)
            kubectl get pods -A -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}' | grep -m 1 $2
            shift
            shift
            ;;
            -s|--namespace)
            kubectl get pods -A -o=jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}' | grep -m 1 $2 | awk '{print $1}'
            shift
            shift
            ;;
            -d|--deployment)
            kubectl get deployment -A -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}' | grep -m 1 $2
            shift
            shift
            ;;
            -*|--*)
            echo "Unknown option $1"
            return 1
            ;;
            *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift
            ;;
        esac
    done
}

function kx() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            update|--update)
            python ~/contexts/rancher-contexts.py
            return 0
            ;;
            -*|--*)
            echo "Unknown option $1"
            return 1
            ;;
            *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift
            ;;
        esac
    done
    kubectx
    echo "Use \"kx --update\" to update cluster credentials"
}