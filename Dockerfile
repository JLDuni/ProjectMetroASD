#FROM python:3.12-slim
#WORKDIR /app
#COPY src/ ./src/
#EXPOSE 5000
#HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
#CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"
#CMD ["python", "src/main.py"]

# ---- Stage 1: build the React frontend ----
FROM node:20-alpine AS frontend
WORKDIR /frontend
COPY frontend/package.json frontend/
RUN npm install
COPY frontend/ ./
RUN npm run build

# ---- Stage 2: build the Go backend ----
FROM golang:1.23-alpine AS backend
WORKDIR /backend
COPY backend/go.mod backend/go.sum* ./
RUN go mod download
COPY backend/ ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /out/metro .

# ---- Stage 3: minimal runtime ----
FROM alpine:3.20
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=backend /out/metro ./metro
COPY --from=frontend /frontend/dist ./static

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -qO- http://localhost:5000/health || exit 1

CMD ["./metro"]