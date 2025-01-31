
## **Install AWS CLI on Ubuntu**

1.  Install **curl** and **unzip** packages
    
    ```sudo apt install curl unzip -y```

2.  Download the **AWS-CLI** sources using the **curl** command
    
    ```curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"```

3.  **Unzip** the downloaded file
    
    ```unzip awscliv2.zip```

4.  Run the **./aws/install** file
    
    ```sudo ./aws/install```

5.  Check if **AWS CLI** is correctly installed in Linux OS
    
    ```aws --version```