# CheeseGoat

## First Challenge - Intermediate
### Specifications:
- An nginx presenting a static web page
- Allow this application to be publicly accessible
- Apply as best practices thinking about security, high availability, failure and costs
- Develop automation with your preferred tool to allow:
    - Deploy the new version of the web application without downtime
    - Rollback to previous version when needed
- Write an adorably good readme, explaining how your solution was designed and how to deploy it

#### Train of Thought
- [x] Just create a simple dockerfile that exposes a static web page 
- [x] Create a Makefile to simplify the process
- [ ] Create simple terraform to deploy it 
- [ ] Create simple Github Actions
- [ ] Deploy it simply with EKS or ECS or even EC2 with more checks...
- [ ] Rollback in terraform simply
> _OBS.:_ Added complexity is to be utilized in the next challenge. If wanted to, it could be simplified.

The best way to solve a problem is first trying to do the easiest thing, so we
get the problem out of the way and then focus on improving it.

So, first we just create a clean docker image that presents us a static page.

Then, we can think about how can we host it...

The simplest way would be just throwing a small ec2, running nginx on that and that's it. This would be pretty straightforward, but we need it to be _high 
available_ and deal with _failures_ as well, to be _high available_ we can just
use a _CloudFront_ to host most of the static files and use a _Load Balancer_ to 
scale these machines in case of a high volume of access. I guess this would be 
the simplest way.

##### Cheap Way

##### Future-Proof Way
