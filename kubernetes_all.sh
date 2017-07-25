for f in /home/justa/dev/kubernetes_repos/*
do
	echo "Tokenize $f"
	./tokenize_repo.sh "$f"
done
