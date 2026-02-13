# EKS Terraform (Seoul, public subnet, addons)

요구사항 기준으로 아래를 한 번에 생성합니다.

- EKS Cluster (서울 리전 기본값)
- Public subnet 기반 VPC
- EKS Managed Node Group
- Addons
  - EBS CSI Driver (EKS addon)
  - AWS Load Balancer Controller (Helm)
  - ExternalDNS (Helm)

## 구조

```text
terraform/
  main.tf                 # 모듈 조립 (network, eks, addons)
  providers.tf            # aws/kubernetes/helm provider
  variables.tf            # 전체 입력 변수
  outputs.tf              # 주요 출력
  versions.tf
  terraform.tfvars.example
  modules/
    network/
      main.tf             # VPC, public subnet, route
      variables.tf
      outputs.tf
    eks/
      main.tf             # EKS cluster, node group, OIDC
      variables.tf
      outputs.tf
    addons/
      main.tf             # EBS CSI, ALB Controller, ExternalDNS
      variables.tf
      outputs.tf
```

## 1) 사전 준비

- AWS 자격증명 설정 (`aws configure` 또는 환경변수)
- Terraform 1.5+

## 2) 배포

```bash
cd /Users/sej/Desktop/INFRA/final-project/terraform
cp terraform.tfvars.example terraform.tfvars
# terraform.tfvars 값 수정
terraform init
terraform plan
terraform apply
```

## 3) kubeconfig 연결

```bash
aws eks update-kubeconfig --region ap-northeast-2 --name <cluster_name>
kubectl get nodes
```

## 추가 고려사항 (이미 반영 또는 변수화)

- EKS control plane log 활성화 기본값 `true`
- API endpoint public CIDR 제한 변수화 (`public_access_cidrs`)
- ALB Controller/ExternalDNS 설치 on/off 변수 제공

## 주의

- 현재 구성은 요청대로 public subnet 중심입니다.
- 운영 환경에서는 private subnet + NAT + endpoint 제한 강화 + IAM 정책 최소권한(특히 ALB Controller)으로 보강을 권장합니다.
# eks-terraform
