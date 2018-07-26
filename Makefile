TILLER_NS := --tiller-namespace ops
TLS_OPTS := --tls --tls-ca-cert /etc/ssl/helm/ca.pem --tls-cert /etc/ssl/helm/cert.pem --tls-key /etc/ssl/helm/key.pem
CHART_REPO := http://jenkins-x-chartmuseum:8080
DIR := "env"
NAMESPACE := "ops-scratch"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm init 
	helm repo add releases ${CHART_REPO}
	helm repo add jenkins-x https://chartmuseum.build.cd.jenkins-x.io
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${TILLER_NS} ${TLS_OPTS} ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${TILLER_NS} ${TLS_OPTS} ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


