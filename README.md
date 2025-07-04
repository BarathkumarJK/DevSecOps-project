# DevSecOps Java CI/CD Pipeline

This project demonstrates a complete **DevSecOps** pipeline implemented using **Jenkins**, integrating **code compilation**, **testing**, **static code analysis**, **security scanning**, **Dockerization**, and **Kubernetes deployment**.

---

## 🔧 Tech Stack

- **Jenkins** (Pipeline as Code - `Jenkinsfile`)
- **Java (OpenJDK 8)** + **Spring Petclinic**
- **Maven** (Build and Dependency Management)
- **Git** (Source Code Management)
- **Gitleaks** (Secrets Detection)
- **SonarQube** (Static Code Analysis)
- **OWASP Dependency Check** (Vulnerability Scanning)
- **Trivy** (Container Image Scanning)
- **Docker** (Image Build and Publish)
- **Kubernetes** (Deployment and Service Management)

---

## 🚀 CI/CD Pipeline Overview

### ✅ Stages Defined in `Jenkinsfile`

1. **Git Checkout**  
   Clones source code from GitHub repository.

2. **Secrets Scan**  
   Uses `gitleaks` to detect hardcoded secrets.

3. **Compile**  
   Compiles Java code using Maven.

4. **Test Cases**  
   Executes unit tests.

5. **SonarQube Analysis**  
   Performs static code analysis and reports code smells, bugs, and vulnerabilities.

6. **OWASP Dependency Check**  
   Scans for vulnerable dependencies.

7. **Build**  
   Packages the application as a `.war` file.

8. **Docker Image Build**  
   Builds a Docker image using the provided Dockerfile.

9. **Push to DockerHub**  
   Authenticates using stored Jenkins credentials and pushes the image.

10. **Trivy Image Scan**  
    Scans the built Docker image for vulnerabilities.

11. **Kubernetes Deployment**  
    Applies `deployment.yaml` and `service.yaml` to deploy to a Kubernetes cluster.

---

## 🐳 Docker

**Image Name:** `yourdockerhub/devsecops-java:v1`

**Dockerfile Highlights:**
- Uses `openjdk:8-jre-alpine`
- Verifies `.war` file integrity with SHA256
- Runs app as a non-root `petclinic` user
- Exposes port `8082`

---

## ☸️ Kubernetes

Kubernetes manifest files (`k8s/deployment.yaml`, `k8s/service.yaml`) are used to deploy the application and expose it as a service.

---

## 🔐 Security Integrations

- **Gitleaks:** Pre-commit hook and Jenkins stage for scanning secrets.
- **SonarQube:** Static code analysis.
- **OWASP Dependency Check:** Detects vulnerable dependencies.
- **Trivy:** Scans Docker images for known CVEs.
- **RBAC in Jenkins:** 
  - `dev` user: Limited access to job triggers and build logs.
  - `test` user: Access to test result analysis.
- **Pre-commit Hook:** Configured to prevent committing secrets locally.

---

## 👥 User Management (RBAC in Jenkins)

- **dev user** – Has access to trigger builds and view pipelines relevant to development.
- **test user** – Restricted to test results and verification roles.

---

## ✅ Pre-commit Hook (Gitleaks)

Ensure Gitleaks runs before every commit:

```bash
# .git/hooks/pre-commit
#!/bin/sh
gitleaks detect --source=. --report-path=gitleaks-precommit.json --verbose
if [ $? -ne 0 ]; then
  echo "❌ Secrets detected. Commit aborted."
  exit 1
fi
```

- Pre-commit hook installed and executable for local `gitleaks` checks:
  ```bash
  chmod +x .git/hooks/pre-commit
  ```

## 📦 Requirements

### Jenkins Setup

- Jenkins installed and running
- Required Jenkins plugins:
  - **Pipeline**
  - **Docker Pipeline**
  - **OWASP Dependency-Check Plugin**
  - **SonarQube Scanner Plugin**
  - **Credentials Binding Plugin**
  - **Git Plugin**

### Jenkins Tools Configuration

- JDK (e.g., JDK 8 or JDK 11) configured as `jdk`
- Maven configured as `maven`
- SonarQube server configured as `sonar-server`
- OWASP Dependency-Check tool installation named `DP`
- DockerHub credentials saved in Jenkins under ID: `docker-hub-credentials`

### Jenkins Agent Requirements

Make sure your Jenkins build agent has the following tools installed and available in the system `PATH`:

- `git`
- `maven`
- `gitleaks`
- `trivy`
- `docker`
- `kubectl`

### External Services

- **SonarQube** server running and accessible from Jenkins
- **DockerHub** account with a repository for image pushing
- **Kubernetes Cluster** (Minikube, k3s, or Cloud-based) configured and accessible via `kubectl`


## 📞 Author

**Name:** Barath Kumar  
**GitHub:** [barathkumarjk](https://github.com/barathkumarjk)  

