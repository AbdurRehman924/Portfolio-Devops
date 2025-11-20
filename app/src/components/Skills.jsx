import React from 'react';

const Skills = () => {
  const skillCategories = [
    {
      title: "Cloud & Platform Engineering",
      skills: [
        "AWS (EC2, VPC, IAM, RDS, Lambda, Load Balancers, CloudWatch)",
        "Google Cloud Platform (GCE, GKE, Cloud Run, IAM, VPC)",
        "Microsoft Azure (Compute, Networking, Monitoring, IAM)",
        "Kubernetes (Workloads, Networking, Ingress, Secrets, Policies)",
        "Docker & Containerization",
        "Cloud-Native Architecture"
      ]
    },
    {
      title: "Infrastructure Engineering & IaC",
      skills: [
        "Terraform (Modules, Multi-Cloud, State Management)",
        "Infrastructure-as-Code (IaC)",
        "GitOps workflows",
        "Automated Provisioning & Scaling"
      ]
    },
    {
      title: "Cloud Security & DevSecOps",
      skills: [
        "IAM Hardening & RBAC",
        "Network Segmentation & Zero-Trust Principles",
        "Encryption Standards (KMS, TLS, secrets management)",
        "Cloud Threat Detection & Proactive Monitoring",
        "Security Compliance (Best practices, audits, scanning)"
      ]
    },
    {
      title: "DevOps, Automation & CI/CD",
      skills: [
        "GitHub Actions (CI/CD pipelines)",
        "Shell Scripting (Automation)",
        "Monitoring & Logging (CloudWatch, Stackdriver/Cloud Logging)",
        "Release Automation & Deployment Orchestration",
        "Container Security & Image Scanning"
      ]
    },
    {
      title: "Programming & Backend Engineering",
      skills: [
        "Node.js",
        "Express.js",
        "JavaScript ES6+",
        "RESTful API Development",
        "MongoDB (Schema design, queries)"
      ]
    },
    {
      title: "Tools & Workflow",
      skills: [
        "Git & Version Control",
        "Linux & Server Administration",
        "Agile / Scrum Practices"
      ]
    },
    {
      title: "Frontend Engineering",
      skills: [
        "React.js",
        "Vue.js",
        "Component-driven UI",
        "State management basics"
      ]
    }
  ];

  return (
    <section id="skills" className="py-20 bg-white">
      <div className="container mx-auto px-6">
        <div className="text-center mb-16">
          <h2 className="text-4xl font-bold text-gray-800 mb-4">Technical Skills</h2>
          <div className="w-16 h-0.5 bg-blue-500 mx-auto"></div>
        </div>

        <div className="max-w-6xl mx-auto grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {skillCategories.map((category, index) => (
            <div
              key={index}
              className={`bg-white border border-gray-100 rounded-xl p-6 shadow-sm hover:shadow-lg hover:scale-105 hover:border-blue-200 transition-all duration-300 ease-in-out  ${index === skillCategories.length - 1 ? 'md:col-span-2 lg:col-span-1 lg:col-start-2' : ''
                }`}
            >
              <h3 className="text-lg font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-100 text-center">
                {category.title}
              </h3>
              <div className="space-y-2 text-left">
                {category.skills.map((skill, skillIndex) => (
                  <div key={skillIndex} className="text-gray-600 text-sm leading-relaxed flex items-start hover:text-gray-800 hover:bg-gray-50 hover:scale-105 transition-all duration-200 ease-in-out p-2 rounded-md ">
                    <span className="text-blue-500 mr-2 mt-1">•</span>
                    <span>{skill}</span>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Skills;
