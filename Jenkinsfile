template = '''
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: terraform
  name: terraform
spec:
  containers:
  - command:
    - sleep
    - "3600"
    image: hashicorp/terraform
    name: terraform
    '''

tfvars = """
region = "${params.region}"
ami_name = "${params.ami_id}"
instance_type = "t2.micro"
az1 = "${params.az}"
key_name = "${params.key_name}"
"""

properties([
  parameters([
    choice(choices: ['apply', 'destroy'], description: 'Select your action', name: 'action'),
    choice(choices: ['us-east-1', 'us-east-2', 'us-west-1', 'us-west-2'], description: 'Enter region', name: 'region'), 
    string(description: 'Enter ami id', name: 'ami_id', trim: true), 
    string(description: 'Enter availability zone', name: 'az', trim: true), 
    string(description: 'Enter your key name', name: 'key_name', trim: true)
    ])
    ])

podTemplate(cloud: 'kubernetes', label: 'terraform', yaml: template) {
    node ("terraform") { 
        container("terraform") {
    stage ("'Checkout SCM") {
        git branch: 'main', url: 'https://github.com/zazuwka/terraform-jenkins-april.git'
    }
 
    withCredentials([usernamePassword(credentialsId: 'aws-creds', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
          stage ("Init") {
        sh "terraform init -backend-config=key=${params.region}/${params.az}/terraform.tfstate"
    }
    if(params.action == "apply") {
      stage ("Apply") {
        writeFile file: 'hello.tfvars', text: tfvars    
        sh "terraform apply -var-file hello.tfvars --auto-approve"
    }
    }     
    else {
      stage ("Destroy") {
        writeFile file: 'hello.tfvars', text: tfvars    
        sh "terraform destroy -var-file hello.tfvars --auto-approve"
    }
    }
}
}
}
}
