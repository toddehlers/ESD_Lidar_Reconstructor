//start 
//
#ifndef _ESDCREATEGRIDDEDPCD_H
#define _ESDCREATEGRIDDEDPCD_H

class esdCreateGriddedPCD
{
	private:
		std::string inputGPCName, outputRasterName;
		float dx, dy, dz;
		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC; 

	protected:

	public:
		esdCreateGriddedPCD();
		~esdCreateGriddedPCD();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void WriteGriddedPCD(void);	
};
#endif