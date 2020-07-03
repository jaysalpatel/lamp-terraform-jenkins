// Jenkinsfile
//credentials refer to jenkins credentials inputed in jenkins server
String credentialsId = 'awsCredentials'
//try catch block
try {
  //checkout the repository
  stage('checkout') {
    node {
      //clean the workspace, clean directory so no errors with the current terraform state
      cleanWs()
      //comb the repo
      checkout scm
    }
  }

  // Run terraform init
  stage('init') {
    node {
      //use credentials binding option to reference a class
      //how to reference aws access keys as environment variables
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
        ansiColor('xterm') {
          sh 'terraform init'
        }
      }
    }
  }

  // Run terraform plan
  stage('plan') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
        ansiColor('xterm') {
          sh 'terraform plan'
        }
      }
    }
  }
  //if environment is in master then run terraform plan and terraform apply
  if (env.BRANCH_NAME == 'master') {

    // Run terraform apply
    stage('apply') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

    // Run terraform show
    stage('show') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ! #! /bin/bash
sudo su

yum update -y

sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd

sudo service httpd start

ls -l var/www

##modify ownership and permissions of the directory

##setting files permissions to apache group from an ec2 user

sudo usermod -a -G apache ec2-user

#log out then log back in again
exit

##verify membership of group 
groups

#change the groupd ownership of /var/www and it contents to the apache group
sudo chown -R ec2-user:apache /var/www

#add group write permissions and to the set group IF
sudo chmod 2775 /var/www

#add group write permissions and to set the group ID on future subdirectories, change the dicretory permissions of /var/www and its subdirectories
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

http://my.public.dns.amazonaws.com/phpinfo.php

sudo yum list installed httpd24 php70 mysql56-server php70-mysqlnd

rm /var/www/html/phpinfo.php

sudo service mysqld start

sudo mysql_secure_installation

sudo yum install php70mbstring.x86_64 php70-zip.x86_64 -y

sudo service httpd restart

cd /var/www/html


]]) {
          ansiColor('xterm') {
            sh 'terraform show'
          }
        }
      }
    }
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}
