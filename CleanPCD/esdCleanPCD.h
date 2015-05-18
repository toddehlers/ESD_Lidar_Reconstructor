//start 
//
#ifndef _ESDCLEANPCD_H
#define _ESDCLEANPCD_H

class esdCleanPCD
{
	private:
		std::string inputGPCName, outputGPCName;
		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr outputGPC;

	protected:

	public:
		esdCleanPCD();
		~esdCleanPCD();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void ReadCleanWrite(void);	
		void ReadThread();

};
#endif