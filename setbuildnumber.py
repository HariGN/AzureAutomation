DOCUMENTATION = """
---
module: setbuildnumber
short_description: Module to set the build number after OS install
description:
  - This module will set the build number in the registry configs so that it can be used
    for reporting purposes to determine the build.
options:
  regname:
    description:
      - 'The registry subkey under HKLM:\Software where the build number will be stored.'
      - 'The base registry path is HKLM:\Software.'
      - 'Example - HKLM:\Software\BUILD'
    required: true
    type: str
  buildnumber:
    description:
      - The build number to set in the registry.
    required: true
    type: str
author:
  - HariGN
"""

EXAMPLES = """
- name: Set build number in registry
  harign.hgnwin.setbuildnumber:
    regname: "MyCompany"
    buildnumber: "2501_xyzabc"
"""

RETURN = """
message:
  description: Friendly message on the status of the module
  type: str
  returned: always
changed:
  description: Whether something changed
  type: bool
  returned: always
"""