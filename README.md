# Infrastructure as a Code (IaC) with Terraform

Um repositório responsável por criar recursos na AWS pode ser um repositório de infraestrutura como código (IaC) que utiliza ferramentas como Terraform ou CloudFormation para provisionar recursos na AWS. Esse repositório pode conter arquivos de configuração que descrevem a infraestrutura desejada, como instâncias EC2, grupos de segurança, balanceadores de carga, bancos de dados, entre outros. Esses arquivos podem ser versionados e gerenciados como código-fonte, permitindo que as alterações na infraestrutura sejam rastreadas e auditadas. Além disso, o repositório pode conter scripts de automação que ajudam a implantar e gerenciar a infraestrutura na AWS.


## Validar localmente

Para validar localmente, é necessário ter o Terraform instalado. Para instalar o Terraform, siga as instruções em [Instalar o Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

Para validar o código, execute o seguinte comando:

```bash
terraform init -backend-config="bucket=iac.francl.in" -backend-config="key=terraform/state/703823507" -backend-config="region=us-east-1"
```

```bash
terraform validate
```

