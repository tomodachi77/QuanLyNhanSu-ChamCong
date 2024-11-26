# INSERT INTO nhanvienthamgiaduan(`MaDuAn`, `MaNhanVien`)

import random

manager_ids = ('NV8120','NV3058','NV1816','NV4036','NV1404','NV2357','NV9225','NV1472','NV1492','NV3795','NV9750','NV7288','NV1271','NV2959','NV7597','NV2582','NV1967','NV5604','NV4052','NV1452','NV6643','NV5918','NV7466','NV9606','NV7743','NV3189','NV2825','NV4355','NV3287','NV2368','NV9225','NV1778','NV3027','NV7556','NV1282','NV8937','NV1371','NV6406','NV8703','NV3290','NV2551','NV6510','NV4526','NV5031','NV8815','NV2137','NV9648','NV6419')
project_ids = ('DA0001', 'DA0002', 'DA0003', 'DA0004', 'DA0005', 'DA0006', 'DA0007', 'DA0008', 'DA0009', 'DA0010', 'DA0011', 'DA0012', 'DA0013', 'DA0014', 'DA0015', 'DA0016', 'DA0017', 'DA0018', 'DA0019', 'DA0020', 'DA0021', 'DA0022', 'DA0023', 'DA0024', 'DA0025', 'DA0026', 'DA0027', 'DA0028', 'DA0029', 'DA0030', 'DA0031', 'DA0032', 'DA0033', 'DA0034', 'DA0035', 'DA0036', 'DA0037', 'DA0038', 'DA0039', 'DA0040', 'DA0041', 'DA0042', 'DA0043', 'DA0044', 'DA0045', 'DA0046', 'DA0047', 'DA0048')

# for m_id, p_id in zip(manager_ids, project_ids):
#     print(f'(\'{p_id}\', \'{m_id}\'),')
    

emp_ids = ('NV7733', 'NV8232', 'NV9199', 'NV3308', 'NV3577', 'NV4286', 'NV6786', 'NV8084', 'NV3205', 'NV4602', 'NV5170', 'NV5775', 'NV7040', 'NV8207', 'NV9548', 'NV1540', 'NV8519', 'NV9375', 'NV2124', 'NV3184', 'NV3614', 'NV5718', 'NV7171', 'NV7938', 'NV8058', 'NV9007', 'NV9858', 'NV2977', 'NV7327', 'NV9983', 'NV2105', 'NV3993', 'NV4112', 'NV5194', 'NV5849', 'NV6043', 'NV6789', 'NV8481', 'NV8938', 'NV9405', 'NV9741', 'NV2231', 'NV5136', 'NV5858', 'NV7803', 'NV7947', 'NV2553', 'NV5235', 'NV5494', 'NV9115', 'NV9714', 'NV4257', 'NV4590', 'NV3265', 'NV5324', 'NV5896', 'NV9240', 'NV9979', 'NV1252', 'NV2034', 'NV8795', 'NV9229', 'NV5474', 'NV9433', 'NV2994', 'NV4620', 'NV5859', 'NV6164', 'NV6713', 'NV8049', 'NV8348', 'NV9964', 'NV3325', 'NV6475', 'NV7197', 'NV8594', 'NV8801', 'NV9885', 'NV2099', 'NV3214', 'NV3678', 'NV3692', 'NV3984', 'NV4906', 'NV6452', 'NV6562', 'NV2569', 'NV3171', 'NV3709', 'NV3728', 'NV6256', 'NV2790', 'NV3300', 'NV4739', 'NV4867', 'NV5594', 'NV7788', 'NV8112', 'NV8971', 'NV9119')
flags = (True, True, True, True, True, True, True, False)

count = 0
for emp_id in emp_ids:
    flag = random.choice(flags)
    if not flag: 
        continue
    else:
        count += 1
        project_id = random.choice(project_ids)
        print(f'(\'{project_id}\', \'{emp_id}\'),')
print(count)