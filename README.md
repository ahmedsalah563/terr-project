# terr-project
secure-app-aws/
│
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
│
└── modules/
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── compute/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── loadbalancer/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── backend_s3/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
