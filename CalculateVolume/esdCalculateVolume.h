//start 
//
#ifndef _ESDCALCULATEVOLUME_H
#define _ESDCALCULATEVOLUME_H

class esdCalculateVolume
{
	private:
		std::string inputGPCName, outputGPCVolName;

		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPC; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr outputVolGPC;

		float kerRadius; // moving kernel radius 

	protected:

	public:
		esdCalculateVolume();
		~esdCalculateVolume();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void WriteMaxPCD(void);	
		void createSubGPC(std::vector<int>, pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &);
		void findVolArea(pcl::PointCloud<pcl::PointXYZ>::Ptr &, float &, float &);
};

#endif