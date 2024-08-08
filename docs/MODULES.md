# Project Refurl Modules

This document provides an overview of the key modules in Project Refurl.

## Core Modules

1. Network Module (`modules/network`)
   - Sets up VPC, subnets, and firewall rules
   - Configures Cloud NAT for outbound internet access

2. Compute Module (`modules/compute`)
   - Manages Compute Engine instances
   - Configures instance groups and auto-scaling

3. Database Module (`modules/database`)
   - Sets up Cloud SQL instances for WordPress and YOURLS
   - Configures read replicas and backup policies

4. Storage Module (`modules/storage`)
   - Manages Cloud Storage buckets for media files and backups
   - Configures lifecycle policies and access controls

5. DNS Module (`modules/dns`)
   - Manages Cloud DNS configurations
   - Sets up custom domains for WordPress and YOURLS

6. Load Balancer Module (`modules/load_balancer`)
   - Configures Global HTTP(S) Load Balancing
   - Sets up SSL termination and health checks

7. Security Module (`modules/security`)
   - Manages IAM roles and permissions
   - Configures Cloud Armor (WAF) rules

8. Monitoring Module (`modules/monitoring`)
   - Sets up Cloud Monitoring dashboards and alerts
   - Configures log-based metrics and custom monitoring

9. WordPress Module (`modules/wordpress`)
   - Manages WordPress installation and configuration
   - Handles plugin and theme management

10. YOURLS Module (`modules/yourls`)
    - Manages YOURLS installation and configuration
    - Configures custom domain and plugins

11. E-commerce Module (`modules/ecommerce`)
    - Integrates WooCommerce with WordPress
    - Configures payment gateways and tax rules

## Advanced Modules

12. AI Content Generation Module (`modules/ai_content_generation`)
    - Integrates with AI services for content creation
    - Manages content quality scoring and filtering

13. Blockchain Integration Module (`modules/blockchain_integration`)
    - Implements content verification using blockchain
    - Manages cryptocurrency payment integrations

14. IoT Integration Module (`modules/iot_integration`)
    - Configures Cloud IoT Core for device management
    - Handles data ingestion and processing from IoT devices

15. Advanced Analytics Module (`modules/advanced_analytics`)
    - Sets up BigQuery for data warehousing
    - Configures data processing pipelines using Dataflow

16. CI/CD Module (`modules/cicd`)
    - Manages Cloud Build pipelines
    - Configures automated testing and deployment

17. Disaster Recovery Module (`modules/disaster_recovery`)
    - Implements multi-region deployments
    - Manages backup and restore procedures

18. Compliance Module (`modules/compliance`)
    - Ensures adherence to regulatory requirements
    - Manages audit logging and reporting

Each module contains its own `README.md` with detailed usage instructions and configuration options.
