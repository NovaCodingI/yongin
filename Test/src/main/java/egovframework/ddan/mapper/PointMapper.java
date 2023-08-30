package egovframework.ddan.mapper;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.ddan.vo.LocationVo;

@Mapper("pMapper")
public interface PointMapper {
	
	
	public int insertList(LocationVo loca);
	
}
