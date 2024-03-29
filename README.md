# AWS IAM Configuration for Third-Party Tool

This Terraform project sets up an AWS IAM user, role, and policy to allow a third-party tool to read AWS configuration data securely. The setup grants read-only access to necessary AWS resources, ensuring minimal access rights in line with the principle of least privilege.

## Prerequisites

Before you begin, ensure you have the following:
- Terraform v0.12+ installed on your machine
- An AWS account with the necessary permissions to create IAM roles, policies, and users
- AWS CLI installed and configured with your AWS credentials

## Project Structure

- `main.tf`: Contains the Terraform configuration for creating the IAM user, role, and policy.
- `.gitignore`: Specifies intentionally untracked files to ignore.
- `README.md`: This file, which provides an overview and instructions for the project.

## Setup Instructions

1. **Clone the Repository:**

    ```
    git clone https://github.com/bitovi/terraform-aws-iam
    ```

2. **Initialize Terraform:**

    Run `terraform init` to initialize a Terraform working directory.

3. **Review the Terraform Plan:**

    Execute `terraform plan` to review the actions Terraform will perform.

4. **Apply the Terraform Configuration:**

    Apply the configuration with `terraform apply`. Confirm the action by typing `yes` when prompted.

5. **Retrieve Sensitive Data:**

    After applying the Terraform configuration, you'll need to manually retrieve the Access Key ID and Secret Access Key for the IAM user:

    ```
    terraform output -raw access_key
    terraform output -raw secret_access_key
    ```

## Using the IAM User and Role

- **IAM User:** This user has been granted the `ReadOnlyAccess` AWS-managed policy to read AWS configurations. Use the Access Key ID and Secret Access Key to configure the third-party tool.
  
- **IAM Role:** The role can be assumed by the created IAM user to perform operations within the permissions granted by the attached policies.

## Security Considerations

- Regularly review the IAM permissions to ensure they align with the current requirements of the third-party tool.
- Monitor the activity of the IAM user and role through AWS CloudTrail.
- Rotate the IAM user's access keys periodically to enhance security.

## Support

For issues or questions regarding the Terraform configuration, please open an issue in the repository or consult the Terraform documentation.
