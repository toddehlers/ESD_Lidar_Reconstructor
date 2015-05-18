//start 
//
#ifndef _ESDCUTFILLVOLUME_H
#define _ESDCUTFILLVOLUME_H

class esdCutFillVolume
{
	private:
		std::string inputGPCNameTime1, inputGPCNameTime2, outputGPCDiffVolName;

		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPCTime1; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPCTime2; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr outputDiffVolGPC;

		float kerRadius; // moving kernel radius 

	protected:

	public:
		esdCutFillVolume();
		~esdCutFillVolume();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void WriteMaxPCD(void);	
		void createSubGPC(std::vector<int>, pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &);
		void findVolArea(pcl::PointCloud<pcl::PointXYZ>::Ptr &, float &, float &);
};

#endif