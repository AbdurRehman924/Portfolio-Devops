import React from 'react';

const About = () => {
  return (
    <section id="about" className="py-20 bg-gray-50">
      <div className="container mx-auto px-6">
        <div className="text-center mb-16">
          <h2 className="text-4xl font-bold text-gray-800 mb-4">About Me</h2>
          <div className="w-16 h-0.5 bg-blue-500 mx-auto"></div>
        </div>

        <div className="max-w-4xl mx-auto">
          <div className="bg-white border border-gray-100 rounded-xl p-8 shadow-sm hover:shadow-lg hover:scale-105 transition-all duration-300 ease-in-out ">
            <div className="space-y-6 text-left leading-relaxed">
              <p className="text-gray-700">
                I'm a <span className="font-medium text-gray-900">DevSecOps-focused Cloud Engineer</span> with hands-on experience building, securing, and scaling cloud environments across AWS, GCP, Azure, and hybrid infrastructures. My work spans from architecting cloud-native, highly available systems to automating infrastructure with Terraform, optimizing application delivery through CI/CD pipelines, and enforcing robust cloud security standards.
              </p>

              <p className="text-gray-700">
                I've led cloud transformation projects, designed multi-cloud IaC architectures, implemented Kubernetes networking and security, and developed automated provisioning workflows that reduce deployment time, costs, and operational overhead. My role often blends infrastructure engineering with security engineering—ranging from IAM hardening and network segmentation to continuous monitoring and cloud threat detection.
              </p>

              <p className="text-gray-700">
                Before transitioning fully into cloud, I spent two years as a <span className="font-medium text-gray-900">full-stack JavaScript developer</span>, building web applications using Node.js, Express.js, Vue.js, React.js, and MongoDB, which gives me a strong understanding of how modern applications run under the hood.
              </p>

              <p className="text-gray-700">
                I'm driven by solving complex infrastructure challenges, building scalable cloud systems, and continuously improving resilience, security, and automation. I aim to contribute to high-impact teams where <span className="font-medium text-gray-900">cloud engineering, DevSecOps, and automation</span> come together to build the future of modern infrastructure.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default About;
