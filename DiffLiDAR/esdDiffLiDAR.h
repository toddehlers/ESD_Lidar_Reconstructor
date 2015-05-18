//start 
//
#ifndef _ESDDIFFLIDAR_H
#define _ESDDIFFLIDAR_H

class esdDiffLiDAR
{
	private:
	
		std::string inputGPCNameTime1, inputGPCNameTime2, PListName, QListName,ptsCorrName;

		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPCTime1; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr inputGPCTime2; 
		pcl::PointCloud<pcl::PointXYZ>::Ptr PList;
		pcl::PointCloud<pcl::PointXYZ>::Ptr QList;
		pcl::PointCloud<pcl::PointXYZ>::Ptr ptsCorr;


		float gridInterval; // moving kernel radius 
		float thLimit; // Threshold limit
		float maxCorresDist;
		
		int plistRead;
		
	protected:

	public:
		esdDiffLiDAR();
		~esdDiffLiDAR();
		void CLHelp(std::string[]);
		void Main(int, std::string[], std::string);	
		void WriteVelocityPCD(void);	
		void createSubGPC(std::vector<int>, pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &);
		void createPList(pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &, float);
		void offsetCalculations(pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointCloud<pcl::PointXYZ>::Ptr &, pcl::PointXYZ &,pcl::PointXYZ &,pcl::PointXYZ &, float, float);
};

#endif