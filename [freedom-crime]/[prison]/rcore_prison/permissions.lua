Permissions = {
    CAN_USE_JOB_COMMANDS = 'can_use_job_commands', -- Player with this permission can use job commands.
    HAS_SERVER_GROUP = 'has_server_group', -- Player with this permission has a server group.
}

-- Permission map for groups.
-- Documentation: How this works >>  https://documentation.rcore.cz/paid-resources/rcore_prison/guides/configure-standalone-server-perms

PermissionMap = {
    ['group.owner'] = {
        Permissions.CAN_USE_JOB_COMMANDS,
        Permissions.HAS_SERVER_GROUP,
    },
    ['group.admin'] = {
        Permissions.CAN_USE_JOB_COMMANDS,
        Permissions.HAS_SERVER_GROUP,
    },
    ['group.police'] = {
        Permissions.CAN_USE_JOB_COMMANDS
    },
    ['group.sheriff'] = {
        Permissions.CAN_USE_JOB_COMMANDS
    },
    ['group.firstreponsder'] = {
        Permissions.CAN_USE_JOB_COMMANDS
    }
}    