docker pull ghcr.io/jlduni/projectmetroasd:latest
docker run -d --name metro-app -p 5000:5000 ghcr.io/jlduni/projectmetroasd:latest


curl http://localhost:5000/health #ping it 