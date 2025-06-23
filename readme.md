# A demo of Will Nguyen
`In-progress`

## I. What to demo?
### Tech Stacks
- Ruby on Rails
  - Proc, Lambda
  - Metaprogramming
  - Mixin
  - Enum
  - Idiomatic Ruby
  - ActiveJob, ActiveStorage, ActionCable
  - Sidekiq, Mailer

- GraphQL
- Elasticsearch
- Docker & Kubernetes
- Unit Test with Rspec
- CI/CD
- Stress Test
- Security Test
- Datadog, Sentry, NewRelic
- NextJS
- Caching
- Multi-tenant

### Coding Skills
- SOLID, DRY, KISS, YAGNI
- Design Patterns
  - Service Object
  - Form Object
  - Policy Pattern (Pundit)
  - Presenter, Decorator
- Best Practices

## II. Requirement
### Functional Requirement
Build a website for recruitment, like glassdoor. Providing functionalities to approve/reject job application.
### Non-Functional Requirement
- Readability
- Performance: The system shall handle 2000 concurrent users with an average response time under 300 milliseconds.
- Security
- Scalability
- Reliability
- Availability
- Maintainability
- Supportability: logging & monitoring, alert
- Usability: UX/UI
- Portability: containerization
- Interoperability: integrate with external system by API, GraphQL, JSON
- Testability: automation test
- Compliance: data retention policy

## Command
``` 
kubectl -n monitoring create token admin-user

```

### Terraform
https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
## Argo
```kubectl create namespace argo```
```kubectl -n argo create token argo-user```

## Argocd
- apply argocd.yaml first, before running skaffold
- argocd read application.yml from git, not in local source. Push changes to git first.
login by `admin` and below secret:
```
kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
