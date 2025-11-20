const Contact = () => {
  return (
    <section className="py-20 bg-white">
      <div className="max-w-4xl mx-auto px-6 text-center">
        <h2 className="text-3xl font-bold text-gray-900 mb-12 animate-bounce">Get In Touch</h2>
        <p className="text-lg text-gray-600 mb-8">
          Open to new challenges and growth opportunities in cloud computing, 
          aiming to make a meaningful impact in the industry.
        </p>
        <div className="space-y-4">
          <div className="p-4 bg-gray-50 rounded-lg">
            <p className="text-gray-500">Email</p>
            <a href="mailto:pure.art.endeavor@gmail.com" className="font-medium text-blue-600 hover:text-blue-800">pure.art.endeavor@gmail.com</a>
          </div>
          <div className="p-4 bg-gray-50 rounded-lg">
            <p className="text-gray-500">LinkedIn</p>
            <a href="https://www.linkedin.com/in/khan-abdurrehman-883653214/" target="_blank" rel="noopener noreferrer" className="font-medium text-blue-600 hover:text-blue-800">https://www.linkedin.com/in/khan-abdurrehman-883653214/</a>
          </div>
          <div className="p-4 bg-gray-50 rounded-lg">
            <p className="text-gray-500">Phone</p>
            <p className="font-medium">+923010755088</p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Contact;
