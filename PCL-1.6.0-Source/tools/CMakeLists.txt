set (SUBSYS_NAME tools)
set (SUBSYS_DESC "Useful PCL-based command line tools")
set (SUBSYS_DEPS common io filters sample_consensus segmentation search kdtree features surface octree registration visualization geometry)
set (DEFAULT ON)
set (REASON "")

PCL_SUBSYS_OPTION (build ${SUBSYS_NAME} ${SUBSYS_DESC} ${DEFAULT} ${REASON})
PCL_SUBSYS_DEPEND (build ${SUBSYS_NAME} DEPS ${SUBSYS_DEPS})

if (build)

  PCL_ADD_EXECUTABLE (pcl_plane_projection ${SUBSYS_NAME} plane_projection.cpp)
  target_link_libraries (pcl_plane_projection pcl_common pcl_io pcl_sample_consensus)

  PCL_ADD_EXECUTABLE (pcl_normal_estimation ${SUBSYS_NAME} normal_estimation.cpp)
  target_link_libraries (pcl_normal_estimation pcl_common pcl_io pcl_features pcl_kdtree)

  PCL_ADD_EXECUTABLE (pcl_boundary_estimation ${SUBSYS_NAME} boundary_estimation.cpp)
  target_link_libraries (pcl_boundary_estimation pcl_common pcl_io pcl_features pcl_kdtree)

  PCL_ADD_EXECUTABLE (pcl_cluster_extraction ${SUBSYS_NAME} cluster_extraction.cpp)
  target_link_libraries (pcl_cluster_extraction pcl_common pcl_io pcl_segmentation pcl_filters pcl_kdtree)

  PCL_ADD_EXECUTABLE (pcl_fpfh_estimation ${SUBSYS_NAME} fpfh_estimation.cpp)
  target_link_libraries (pcl_fpfh_estimation pcl_common pcl_io pcl_features pcl_kdtree)

  PCL_ADD_EXECUTABLE (pcl_pcd2ply ${SUBSYS_NAME} pcd2ply.cpp)
  target_link_libraries (pcl_pcd2ply pcl_common pcl_io)

  PCL_ADD_EXECUTABLE (pcl_ply2pcd ${SUBSYS_NAME} ply2pcd.cpp)
  target_link_libraries (pcl_ply2pcd pcl_common pcl_io)

  PCL_ADD_EXECUTABLE (pcl_pcd2vtk ${SUBSYS_NAME} pcd2vtk.cpp)
  target_link_libraries (pcl_pcd2vtk pcl_common pcl_io)

  PCL_ADD_EXECUTABLE (pcl_vfh_estimation ${SUBSYS_NAME} vfh_estimation.cpp)
  target_link_libraries (pcl_vfh_estimation pcl_common pcl_io pcl_features pcl_kdtree)
  
  PCL_ADD_EXECUTABLE (pcl_spin_estimation ${SUBSYS_NAME} spin_estimation.cpp)
  target_link_libraries (pcl_spin_estimation pcl_common pcl_io pcl_features pcl_kdtree)

  PCL_ADD_EXECUTABLE (pcl_voxel_grid ${SUBSYS_NAME} voxel_grid.cpp)
  target_link_libraries (pcl_voxel_grid pcl_common pcl_io pcl_filters)
	
  PCL_ADD_EXECUTABLE (pcl_passthrough_filter ${SUBSYS_NAME} passthrough_filter.cpp)
  target_link_libraries (pcl_passthrough_filter pcl_common pcl_io pcl_filters)
	
  PCL_ADD_EXECUTABLE (pcl_extract_feature ${SUBSYS_NAME} extract_feature.cpp)
  target_link_libraries (pcl_extract_feature pcl_common pcl_io pcl_features pcl_kdtree)
  
  PCL_ADD_EXECUTABLE (pcl_compute_cloud_error ${SUBSYS_NAME} compute_cloud_error.cpp)
  target_link_libraries (pcl_compute_cloud_error pcl_common pcl_io pcl_kdtree)
  
  PCL_ADD_EXECUTABLE (pcl_add_gaussian_noise ${SUBSYS_NAME} add_gaussian_noise.cpp)
  target_link_libraries (pcl_add_gaussian_noise pcl_common pcl_io)
  
  PCL_ADD_EXECUTABLE (pcl_outlier_removal ${SUBSYS_NAME} outlier_removal.cpp)
  target_link_libraries (pcl_outlier_removal pcl_common pcl_io pcl_filters)
  
  PCL_ADD_EXECUTABLE (pcl_mls_smoothing ${SUBSYS_NAME} mls_smoothing.cpp)
  target_link_libraries (pcl_mls_smoothing pcl_common pcl_io pcl_surface pcl_filters)
  
  PCL_ADD_EXECUTABLE (pcl_marching_cubes_reconstruction ${SUBSYS_NAME} marching_cubes_reconstruction.cpp)
  target_link_libraries (pcl_marching_cubes_reconstruction pcl_common pcl_io pcl_surface)

  PCL_ADD_EXECUTABLE (pcl_gp3_surface ${SUBSYS_NAME} gp3_surface.cpp)
  target_link_libraries (pcl_gp3_surface pcl_common pcl_io pcl_surface)
  
  PCL_ADD_EXECUTABLE(pcl_icp ${SUBSYS_NAME} icp.cpp)
  target_link_libraries(pcl_icp pcl_common pcl_io pcl_registration)

  PCL_ADD_EXECUTABLE(pcl_icp2d ${SUBSYS_NAME} icp2d.cpp)
  target_link_libraries(pcl_icp2d pcl_common pcl_io pcl_registration)

  PCL_ADD_EXECUTABLE(pcl_elch ${SUBSYS_NAME} elch.cpp)
  target_link_libraries(pcl_elch pcl_common pcl_io pcl_registration)
 
  PCL_ADD_EXECUTABLE(pcl_poisson_reconstruction ${SUBSYS_NAME} poisson_reconstruction.cpp)
  target_link_libraries(pcl_poisson_reconstruction pcl_common pcl_io pcl_surface)

  if (QHULL_FOUND)
    PCL_ADD_EXECUTABLE(pcl_crop_to_hull ${SUBSYS_NAME} crop_to_hull.cpp)
    target_link_libraries(pcl_crop_to_hull pcl_common pcl_io pcl_filters pcl_surface)
  endif (QHULL_FOUND)

  if(NOT VTK_FOUND)
    set(DEFAULT FALSE)
    set(REASON "VTK was not found.")
  else(NOT VTK_FOUND)
      set(DEFAULT TRUE)
      set(REASON)
      set(VTK_USE_FILE ${VTK_USE_FILE} CACHE INTERNAL "VTK_USE_FILE")
      include (${VTK_USE_FILE})
      include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
      
      PCL_ADD_EXECUTABLE(pcl_registration_visualizer ${SUBSYS_NAME} registration_visualizer.cpp)
      target_link_libraries(pcl_registration_visualizer pcl_common pcl_io pcl_kdtree pcl_filters pcl_registration pcl_visualization)

      PCL_ADD_EXECUTABLE(pcl_octree_viewer ${SUBSYS_NAME} octree_viewer.cpp)
      target_link_libraries(pcl_octree_viewer pcl_common pcl_io pcl_octree pcl_visualization pcl_kdtree pcl_filters)

      PCL_ADD_EXECUTABLE(pcl_mesh2pcd ${SUBSYS_NAME} mesh2pcd.cpp)
      target_link_libraries(pcl_mesh2pcd pcl_common pcl_io pcl_visualization pcl_filters vtkCommon)
      
      PCL_ADD_EXECUTABLE(pcl_mesh_sampling ${SUBSYS_NAME} mesh_sampling.cpp)
      target_link_libraries(pcl_mesh_sampling pcl_common pcl_io pcl_visualization pcl_filters vtkCommon)
      
      PCL_ADD_EXECUTABLE(pcl_virtual_scanner ${SUBSYS_NAME} virtual_scanner.cpp)
      target_link_libraries(pcl_virtual_scanner pcl_common pcl_io pcl_filters pcl_visualization vtkCommon vtkGraphics)
      
      if(BUILD_OPENNI AND OPENNI_FOUND)
        PCL_ADD_EXECUTABLE(pcl_openni_save_image ${SUBSYS_NAME} openni_save_image.cpp)
        target_link_libraries(pcl_openni_save_image pcl_common pcl_io pcl_visualization)  
      endif(BUILD_OPENNI AND OPENNI_FOUND)
  endif(NOT VTK_FOUND)

  PCL_ADD_EXECUTABLE (pcl_transform_point_cloud ${SUBSYS_NAME} transform_point_cloud.cpp)
  target_link_libraries (pcl_transform_point_cloud pcl_common pcl_io pcl_registration)

  PCL_ADD_EXECUTABLE (pcl_transform_from_viewpoint ${SUBSYS_NAME} transform_from_viewpoint.cpp)
  target_link_libraries (pcl_transform_from_viewpoint pcl_common pcl_io pcl_registration)

  find_package(tide QUIET)
  if(Tide_FOUND)
      include_directories(${Tide_INCLUDE_DIRS})
      add_definitions(${Tide_DEFINITIONS})
      PCL_ADD_EXECUTABLE(pcl_video ${SUBSYS_NAME} pcl_video.cpp)
      target_link_libraries(pcl_video pcl_common pcl_io pcl_visualization
          ${Tide_LIBRARIES})
  endif(Tide_FOUND)

endif ()
