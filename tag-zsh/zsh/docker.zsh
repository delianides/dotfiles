function docker-cleanup(){
	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

function docker-delete-stopped(){
	local name=$1
	local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm $name
	fi
}

function docker-default(){
  docker-machine restart default
  eval $(docker-machine env default)
}

function relies_on(){
	local containers=$@

	for container in $containers; do
		local state=$(docker inspect --format "{{.State.Running}}" $container 2>/dev/null)

		if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
			echo "$container is not running, starting it for you."
			$container
		fi
	done
}

aws(){
	docker run -it --rm \
		-v $HOME/.aws:/root/.aws \
		--log-driver none \
		--name aws \
		jess/awscli "$@"
}

jiracli(){
	docker run -it --rm \
		-v $HOME/.jiracli.ini:/root/.jiracli.ini \
		--log-driver none \
		--name jiracli \
		delianides/jiracli "$@"
}

irssi() {
  docker rm -f irssi
	docker run --rm -it \
    --log-driver=none \
    -u $(id -u):$(id -g) \
		-v $HOME/.dotfiles/irssi:/home/user/.irssi \
    -e IRC_PASSWORD=$IRC_PASSWORD \
		--name irssi \
		irssi
}

t(){
	docker run -t --rm \
		-v $HOME/.trc:/root/.trc \
		--log-driver none \
		jess/tcli "$@"
}