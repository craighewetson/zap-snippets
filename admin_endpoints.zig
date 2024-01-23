const std = @import("std");
const zap = @import("zap");

pub const Self = @This();

pub fn init(listener: *zap.Endpoint.Listener) !void {
    const speakersEndpoint = zap.Endpoint.init(.{
       .path = "/admin/speakers",
        .get = listSpeakers,
    });
    try listener.register(@constCast(&speakersEndpoint));
}

fn listSpeakers(e: *zap.Endpoint, r: zap.Request) void {
  _ = e;
 r.sendBody("<html><body><h1>Speakers<h1></body></html>") catch return;
}
